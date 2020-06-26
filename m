Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F768C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7115206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9KAVpxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7115206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorhS-00013K-4F
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jorUY-0003Ks-5G
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:46:18 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:44579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jorUW-0007tO-Ak
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:46:17 -0400
Received: by mail-ej1-x641.google.com with SMTP id ga4so9971590ejb.11
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BNWksxwKvN4OS9zdvud/coWuMVdM1gG/KovFbz0SPRc=;
 b=M9KAVpxL/Ng459P7eKivVpdYefVfyq7X+2OFu9jTWKXZ8pndQ7jrBqr0fYnseanRz0
 6kWvTpuXj/BrZz1Q3vcnv1KNOBadzsysolSRNXRtTwyxS/VpWDzjBm5U4X9QHgHDoR69
 vZB8pamfjIEAvke0ZLsolSGlaJZQStfr/AjEJW3X40pAbsSCyAPC2ZBp+Trxz8tDT6S0
 wLDbHo68iX3K7v40JeW1lLKXYE8bTiUthjp5I635x2B5mr6ZRM33KwGjiFkb8TsdGd6p
 nieaZ4e1ekB1cKGU66CaU3BipjrGSnt+Ax/sUTe8LdcjA2xKvFmJ7pIyaPa/MfsI3I6E
 q8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BNWksxwKvN4OS9zdvud/coWuMVdM1gG/KovFbz0SPRc=;
 b=cOrcnUlQdtIz9SCNIyINLGrf2L60rksoReLBJtThki0Q2De1ky7lJ53ATExCs4tlne
 jL/d3xOZ7rEJDPk2qayoj32DMsmwvrq+33PNkcdc1vZDVLuVXlLEbI/8sj54C6KWx6I6
 XLgx6Sw4YLMDHZKEG6hruY03GzE6c3Py0DRzA6HgRj1QCCCPwwjX8Jle7gvAMIrZnWrw
 sRQcSUO77VsG/0DTdA5f8LC7ScZkCJLOBBzlioDFeN8AFcz9R6NwL+UjQUM5bAVr1X4q
 lHlh0NwTUyXoEEGqWw5vUdl9d8Nu4ZBf6lmKZKJuGvtUaFkCb6KfGlXYol30ujMs5VGz
 YHLw==
X-Gm-Message-State: AOAM533K/PWboHQivKwLNIlJfWZyTO0rak9D79woMJt+K3BIC5tPjN/9
 USMG6NSebth7PWK3AM646qmi8LV1
X-Google-Smtp-Source: ABdhPJxni4I2NDuam1b+Vwc8J69zJXqIxN9oKq4sx3jjPGNPKMR3G7V28tQV11yMzRLbazmu/8axUA==
X-Received: by 2002:a17:906:1151:: with SMTP id
 i17mr3490327eja.535.1593189974518; 
 Fri, 26 Jun 2020 09:46:14 -0700 (PDT)
Received: from AK-L.domain.name ([197.58.224.183])
 by smtp.gmail.com with ESMTPSA id rv16sm10894889ejb.60.2020.06.26.09.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:46:13 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, rth@twiddle.net, eblake@redhat.com,
 ldoktor@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v4 0/3] Add Scripts for Finding Top 25 Executed Functions
Date: Fri, 26 Jun 2020 18:45:43 +0200
Message-Id: <20200626164546.22102-1-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greetings,

As a part of the TCG Continous Benchmarking project for GSoC this
year, detailed reports discussing different performance measurement
methodologies and analysis results will be sent here on the mailing
list.

The project's first report was published on the mailing list on the
22nd of June:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html

A section in this report deals with measuring the top 25 executed
functions when running QEMU. It includes two Python scripts that
automatically perform this task.

This series adds these two scripts to a new performance directory
created under the scripts directory. It also adds a new
"Miscellaneous" section to the end of the MAINTAINERS file with a
"Performance Tools and Tests" subsection.

Previous versions of the series:
v3:
https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg07856.html
v2:
https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg06147.html
v1:
https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg04868.html

Best regards,
Ahmed Karaman

v3->v4:
- Save all intermediate files generated by the scripts in the '/tmp'
  directory instead of the current working directory of the user.
- Use more descriptive variable names and table headers.

v2->v3:
- Use a clearer "Syntax" and "Example of usage" in the script comment
  and commit message.
- Manually specify the instructions required to run Perf instead of
  relying on the stderr produced by Perf.
- Use more descriptive variable names.

v1->v2:
- Add an empty line at the end of the MAINTAINERS file.
- Move MAINTAINERS patch to be the last in the series.
- Allow custom number of top functions to be specified.
- Check for vallgrind and perf before executing the scripts.
- Ensure sufficient permissions when running the topN_perf script.
- Use subprocess instead of os.system
- Use os.unlink() for deleting intermediate files.
- Spread out the data extraction steps.
- Enable execution permission for the scripts.
- Add script example output in the commit message.


Ahmed Karaman (3):
  scripts/performance: Add topN_perf.py script
  scripts/performance: Add topN_callgrind.py script
  MAINTAINERS: Add 'Performance Tools and Tests'subsection

 MAINTAINERS                           |   7 ++
 scripts/performance/topN_callgrind.py | 140 ++++++++++++++++++++++++
 scripts/performance/topN_perf.py      | 149 ++++++++++++++++++++++++++
 3 files changed, 296 insertions(+)
 create mode 100755 scripts/performance/topN_callgrind.py
 create mode 100755 scripts/performance/topN_perf.py

-- 
2.17.1


