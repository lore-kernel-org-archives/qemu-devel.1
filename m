Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F43FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 00:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7807021734
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 00:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HU6erWKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7807021734
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN3iF-0003gs-Hf
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 20:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3S4JyXwsKChw9KCAFF6EG6F8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--hskinnemoen.bounces.google.com>)
 id 1kN3gF-0002HA-5x
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 20:39:43 -0400
Received: from mail-qk1-x749.google.com ([2607:f8b0:4864:20::749]:55211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3S4JyXwsKChw9KCAFF6EG6F8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--hskinnemoen.bounces.google.com>)
 id 1kN3gD-0000PV-D1
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 20:39:42 -0400
Received: by mail-qk1-x749.google.com with SMTP id r184so1663085qka.21
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 17:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=cQm7cQnpxJnDzr+vk7QqhOO9BS7RbVnXECEf70CLEk4=;
 b=HU6erWKPw9aMyTgiKxlAcd2qHr20i+LP1CvcEwXrgmv16+zZwShULOzZz/tNutSUZt
 530oaldDcj8awRacuv7AyiKzGAQdLZM9UwE24th1UIvUSD6dwtRLILTxXO+/njkIqA1i
 ywOP7c9c2y0omiqdRTFNZ3U1T8Fxsu0px7oDXDmogJSOY7swrjbT2o5DuPE+QDMOzzo1
 JxgZMaRuYSa/k2iG9JwPJf+ywvdVyxHRep0EPsZiHCqcMpcoSGKsedHySRaKUh5e4Vdy
 QabkwPte1fOi1jwq0AxhEZIcQ6donG8/IQrNAM6g5krup8w5yuFHpVLJnMBfWVrJYSw3
 cNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=cQm7cQnpxJnDzr+vk7QqhOO9BS7RbVnXECEf70CLEk4=;
 b=nKt97U6VI1oHy/k8rZabb2BRtUNihNHNjl58BbLwHWKvZBc3ZQLzb7c6/mj5P0KjNC
 KN6JJDsy0FbyyQ28kVOHFeqcQKSVfWIiXVm80fHONkekVTdt0P1AwbgeDR7Ivz78/Yht
 7WlVz7Wok5UO2AYYsE6t/arRnzex96bzixgKhrwXEcEYqydciCpl0g26Og0Nqr7fJb4z
 pgHVxoHlODSFQzI5jlhpLog5agxbK3JoM4a3sTj/k3Z3G+8R8lmJAjaEyFBkj+lj9E37
 rcyYnhKILoJO/STRg1mIDBG4fbHRas3jtGY5PntHP0XSmBAW8uN/lLtG8MXMZ2W7GTNZ
 9s7A==
X-Gm-Message-State: AOAM53287dUGNutQuhpJWINnXhVskiOobXYxSueC9HK0QHZ/m6yh1zHj
 KurE03jcFZMEO5FoQc5ErfJ2noXFqcPHrMGC7uZZdWbz8OLLXLnBRMhuPBgeJ6i2oVUHvdJgN0D
 eHXa9iSEYzqsFA4UUy8UgtZ03/Y4RcbOmU6Mr/GU6GzphXXDHIIVgo3dkNIFL4lrwx9YW6qOa8A
 ==
X-Google-Smtp-Source: ABdhPJwcbn6pxAJejfFvxdbgXmAxP0hPbeo0iA2hBs+h4G2i5Dafpfg2tOJWLEdp/l7awGmWVQnOjXMeGdwdOPoJoA==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:ad4:4b61:: with SMTP id
 m1mr2320198qvx.11.1601339979400; Mon, 28 Sep 2020 17:39:39 -0700 (PDT)
Date: Mon, 28 Sep 2020 17:39:15 -0700
In-Reply-To: <20200929003916.4183696-1-hskinnemoen@google.com>
Message-Id: <20200929003916.4183696-3-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200929003916.4183696-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [RFC 2/3] docs/specs: IPMI device emulation: main processor
To: qemu-devel@nongnu.org
Cc: Avi.Fishman@nuvoton.com, kfting@nuvoton.com, joel@jms.id.au, clg@kaod.org, 
 venture@google.com, wuhaotsh@google.com, minyard@acm.org, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::749;
 envelope-from=3S4JyXwsKChw9KCAFF6EG6F8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--hskinnemoen.bounces.google.com;
 helo=mail-qk1-x749.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.468,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

This document is an attempt to briefly document the existing IPMI
emulation support on the main processor. It provides the necessary
background for the BMC-side IPMI emulation proposed by the next patch.

Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 docs/specs/index.rst |   1 +
 docs/specs/ipmi.rst  | 100 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 docs/specs/ipmi.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 1b0eb979d5..9fdb94a578 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -14,5 +14,6 @@ Contents:
    ppc-spapr-xive
    ppc-spapr-numa
    acpi_hw_reduced_hotplug
+   ipmi
    tpm
    acpi_hest_ghes
diff --git a/docs/specs/ipmi.rst b/docs/specs/ipmi.rst
new file mode 100644
index 0000000000..e0f9ab20ba
--- /dev/null
+++ b/docs/specs/ipmi.rst
@@ -0,0 +1,100 @@
+=====================
+IPMI device emulation
+=====================
+
+QEMU supports emulating many types of machines. This includes machines that may
+serve as the main processor in an IPMI system, e.g. x86 or POWER server
+processors, as well as machines emulating ARM-based Baseband Management
+Controllers (BMCs), e.g. AST2xxx or NPCM7xxx systems-on-chip.
+
+Main processor emulation
+========================
+
+A server platform may include one of the following system interfaces for
+communicating with a BMC:
+
+* A Keyboard Controller Style (KCS) Interface, accessible via ISA
+  (``isa-ipmi-kcs``) or PCI (``pci-ipmi-kcs``).
+* A Block Transfer (BT) Interface, accessible via ISA (``isa-ipmi-bt``) or PCI
+  (``pci-ipmi-bt``).
+* An SMBus System Interface (SSIF; ``smbus-ipmi``).
+  
+These interfaces can all be emulated by QEMU. To emulate the behavior of the
+BMC, the messaging interface emulators use one of the following backends:
+
+* A BMC simulator running within the QEMU process (``ipmi-bmc-sim``).
+* An external BMC simulator or emulator, connected over a chardev
+  (``ipmi-bmc-extern``). `ipmi_sim
+  <https://github.com/wrouesnel/openipmi/blob/master/lanserv/README.ipmi_sim>`_
+  from OpenIPMI is an example external BMC emulator.
+
+The following diagram shows how these entities relate to each other.
+
+.. blockdiag::
+
+    blockdiag main_processor_ipmi {
+        orientation = portrait
+        default_group_color = "none";
+        class msgif [color = lightblue];
+        class bmc [color = salmon];
+
+        ipmi_sim [color="aquamarine", label="External BMC"]
+        ipmi-bmc-extern <-> ipmi_sim [label="chardev"];
+
+        group {
+            orientation = portrait
+
+            ipmi-interface <-> ipmi-bmc;
+
+            group {
+                orientation = portrait
+
+                ipmi-interface [class = "msgif"];
+                isa-ipmi-kcs [class="msgif", stacked];
+
+                ipmi-interface <- isa-ipmi-kcs [hstyle = generalization];
+            }
+
+
+            group {
+                orientation = portrait
+
+                ipmi-bmc [class = "bmc"];
+                ipmi-bmc-sim [class="bmc"];
+                ipmi-bmc-extern [class="bmc"];
+
+                ipmi-bmc <- ipmi-bmc-sim [hstyle = generalization];
+                ipmi-bmc <- ipmi-bmc-extern [hstyle = generalization];
+            }
+
+        }
+    }
+
+IPMI System Interfaces
+----------------------
+
+The system software running on the main processor may use a *system interface*
+to communicate with the BMC. These are hardware devices attached to an ISA, PCI
+or i2c bus, and in QEMU, they all need to implement ``ipmi-interface``.
+This allows a BMC implementation to interact with the system interface in a
+standard way.
+
+IPMI BMC
+--------
+
+The system interface devices delegate emulation of BMC behavior to a BMC
+device, that is a subclass of ``ipmi-bmc``. This type of device is called
+a BMC because that's what it looks like to the main processor guest software.
+
+The BMC behavior may be simulated within the qemu process (``ipmi-bmc-sim``) or
+further delegated to an external emulator, or a real BMC. The
+``ipmi-bmc-extern`` device has a required ``chardev`` property which specifies
+the communications channel to the external BMC.
+
+Wire protocol
+=============
+
+The wire protocol used between ``ipmi-bmc-extern`` and the external BMC
+emulator is defined by `README.vm
+<https://github.com/wrouesnel/openipmi/blob/master/lanserv/README.vm>`_ from
+the OpenIPMI project.
-- 
2.28.0.709.gb0816b6eb0-goog


