Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEAFC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D8922DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="2hh4BAez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D8922DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0TuW-00049b-3M
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0Ta8-0007tg-5g
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0Ta6-0006Cd-PU
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:32 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:36506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i0Ta6-0006Bt-Fl
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:30 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 37FC296F56;
 Wed, 21 Aug 2019 16:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1566405329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BR3eridDeouQ+ZfE9j4HBjTSNzRxIpuXQwC0lZSXRw=;
 b=2hh4BAez+k2D75Mso0k7eea36N1cRG5Vw0XGPBO+50R4TDtQskzOXCnnrea3c4swsdard+
 6RNuD7BKc1cKf7QpFL49CM2H6lL0QzhUB43a82fI0DX19hzDm++cxl6XWAGSPmbEnr9N/4
 EHxtvwT67qyvOb4nmo9w9TGtPiWbnL4=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 18:33:41 +0200
Message-Id: <20190821163341.16309-11-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821163341.16309-1-damien.hedde@greensocs.com>
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1566405329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BR3eridDeouQ+ZfE9j4HBjTSNzRxIpuXQwC0lZSXRw=;
 b=C6cas6EmaSKbb/7RvHLBDI+LBytvNe17O7DS2ja5KD+tjb+L0qrF4Mf/qnoyBRmWSLXYtN
 xxwYEZiNDw7NeBRqSf1uyrN6GidMbDnzEJzQ4dl5Y1tmzRJVBkREZwPQ/uvSY+8xcmMhuH
 ViDinnU+kKmcyFyCsI+fxnlsZpBswA8=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1566405329; a=rsa-sha256; cv=none;
 b=auUOw8C4R+1wmvrmoFFW3MpmAuPceMMtoj5n3r2Qf9nYuf3cnzNeyvjiyU/0leAteZIA/C
 OF2gp3K7rNZVSshUIs8RSdDVQqDJVG13wdlwnYumr3Uqi7N3SwzPly5b63DoAKjD+83NYo
 oeuPxqVrcm2El/9mNQJ3HUuib5tLMog=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v4 10/10] docs/devel/reset.txt: add
 documentation about warm reset
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 edgar.iglesias@xilinx.com, berrange@redhat.com, ehabkost@redhat.com,
 mark.burton@greensocs.com, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Complete the documentation with the handling of several reset types
(cold and warm).

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 docs/devel/reset.txt | 55 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/docs/devel/reset.txt b/docs/devel/reset.txt
index 77ff29b3d7..ed1a72566d 100644
--- a/docs/devel/reset.txt
+++ b/docs/devel/reset.txt
@@ -31,16 +31,21 @@ makes no difference. But there can be some; some conf=
iguration may be kept when
 applying a warm reset for example.
=20
 The Resettable interface handles reset kinds with an enum. For now only =
cold
-reset is defined, others may be added later.
+and warm reset are defined, others may be added later.
 ```
 typedef enum ResetType {
     RESET_TYPE_COLD,
+    RESET_TYPE_WARM,
 } ResetType;
 ```
=20
 In qemu, RESET_TYPE_COLD means we reset to the initial state correspondi=
ng to
 the start of qemu; this might differs from what is a read hardware cold =
reset.
=20
+Although the interface can handle several kind of resets, these are not =
totally
+independant and disjoint. There are some constraints; these are explaine=
d below
+in the "multi-phase" section.
+
=20
 Triggering reset
 ----------------
@@ -49,21 +54,41 @@ This section documents the APIs which "users" of a re=
settable object should use
 to control it. All resettable control functions must be called while hol=
ding
 the iothread lock.
=20
-You can trigger a reset event on a resettable object with resettable_res=
et().
-The object will be instantly reset.
+A resettable object can be put into its "in reset" state and held there
+indefinitely.
+
+You must call resettable_assert_reset() to put an object in reset. It wi=
ll stay
+in this state until you eventually call resettable_deassert_reset(). Car=
e must
+be taken to call resettable_deassert_reset() once and only once per call=
 of
+resettable_assert_reset().
+
+```resettable_assert_reset(Object *obj, ResetType type);```
+The parameter "obj" is an object implementing the Resettable interface.
+The parameter "type" gives the type of reset you want to trigger.
+
+```resettable_deassert_reset(Object *obj);```
+The parameter "obj" is an object implementing the Resettable interface.
+
+If you want to just trigger a reset event but not leave the object in re=
set for
+any period of time, you can use resettable_reset(), which is a convenien=
ce
+function identical in behaviour to calling resettable_assert() and then
+immediately calling resettable_deassert().
=20
 ```void resettable_reset(Object *obj, ResetType type);```
 The parameter "obj" is an object implementing the Resettable interface.
 The parameter "type" gives the type of reset you want to trigger.
=20
 It is possible to interleave multiple calls to
+ - resettable_assert_reset(),
+ - resettable_deassert_reset(),
  - resettable_reset().
=20
 There may be several reset sources/controllers of a given object. The in=
terface
 handles everything and the different reset controllers do not need to kn=
ow
 anything about each others. The object will leave reset state only when =
each
 other controllers end their reset operation. This point is handled by
-maintaining a count of reset.
+maintaining a count of reset; this is why resettable_deassert_reset() mu=
st be
+called once and only once per resettable_assert_reset().
=20
 Note that it is a programming error to call a resettable function on a
 non-Resettable object and it will trigger a run time assert error. Since=
 most
@@ -74,6 +99,8 @@ For Devices and Buses, the following helper functions e=
xists:
 ```
 void device_cold_reset(Device *dev);
 void bus_cold_reset(Bus *bus);
+void device_warm_reset(Device *dev);
+void bus_warm_reset(Bus *bus);
 ```
=20
 These are simple wrappers around resettable_reset() function; they only =
cast the
@@ -123,6 +150,25 @@ The exit phase is executed only when the last reset =
operation ends. Therefore
 the object has not to care how many reset controllers it has and how man=
y of
 them have started a reset.
=20
+An exception to that is when entering a new reset type AND if there was =
no
+previous cold reset; in that case, init and hold methods are executed ag=
ain
+because the different reset type may reset more things than the previous=
 one
+has done.
+
+For example if some controller has started a RESET_TYPE_WARM with
+resettable_assert_reset() on a device and another controller does a
+device_cold_reset() on the same object, then the init phase is executed =
with
+RESET_TYPE_COLD as an argument and then the hold phase.
+If the first reset was a cold reset, then the warm reset would have trig=
gered
+nothing because the cold reset is "stronger".
+
+Note also that the exit phase will never be executed twice; it will only=
 be
+executed when all reset operation are closed, independently of the numbe=
r of
+reset types that were issued. This is a limitation of the interface, the=
re is
+only a global count of reset (not a count per reset type). The consequen=
ce is
+that the different reset types must be close enough in behavior to not r=
equire
+different exit phases.
+
=20
 Handling reset in a new resettable object
 -----------------------------------------
@@ -203,6 +249,7 @@ interface.
 typedef struct ResetState {
     uint32_t count;
     bool hold_phase_needed;
+    ResetType type;
 } ResetState;
=20
 typedef ResetState *(*ResettableGetState)(Object *obj);
--=20
2.22.0


