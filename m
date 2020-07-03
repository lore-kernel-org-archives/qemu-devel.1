Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16CFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79702207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="eIBfKygr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79702207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOhP-0006IT-KH
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrOdd-0007YH-6c
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:34:09 -0400
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:53502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrOdb-0008FQ-BU
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
 s=dk12062016; t=1593794047; bh=G0Vmuk9F1p1Qrm7HZ4G/fg4rij9zRIqoPgDi
 RkXCERU=; h=Received:Message-ID:Date:From:User-Agent:MIME-Version:
 To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:
 X-Originating-IP; b=eIBfKygrvgl4D0TKS1g6jUVb2rIwgD5QfVMty+lWw+13uR
 ME4UkFGLyYC7t1jHWITS3rymV9FX8Kim5ziffzd6rNw03aKnzhb9KIV2nzW6cc5mF1i
 BNWXUOsYk9OrV1nSyLuwfEJYdNLRizPyzxeoJV/k8VIk2oXo6aKsuSiXu5m/1r0RI/N
 wxir0rGvM6H8mXdcotWcj559cyci9A0UwtKufuKd6bq6pnKTNIHyXqtiQPYln9+mB/o
 uadp7yp6daKGy24IBuZKXQ5Xv3NRVICSiZVYpuWORhBSXRjZ0H5i4+LpuqdYRDjZ849
 2XfHfIR7kXjUs9QAv8z8DCvWX+mg==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
 s=dk12062016; d=mindspring.com;
 b=IaweK0VXj4bOvem5q029XkeWOrX9ttGnq0kFwkuhLjwJwEIIm3tKsQjHV5U2GhF7uU2dH2DMCWbCGjznSW/7VZ5nyIimhE7gWp3Q8QkTt9eAex8dZjExNESng8Mx7GEKw3WRUII9K2yD+dEd8+MqJ21+TdfVJ+8v0MAOAnEtZIy5WTxySSVEJpBL9XRspABmoG1wddTNv8GlOmt5v+FXp+MJEZY2ygkLPhYYYsvu54/DJm7B+hjSZrqS1k6C5eQK8YXhEGxWE9/seyrrWd3+19dyEpD5NiW+tldI1ISyUDAHj3ISf/Pl+t7zWWUyUV/VyZKWpVS9SAfj7ECzLwPAog==;
 h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:X-Originating-IP;
Received: from [8.9.81.230] (helo=[192.168.0.78])
 by elasmtp-masked.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <denber@mindspring.com>)
 id 1jrOdZ-0000zF-7y; Fri, 03 Jul 2020 12:34:05 -0400
Message-ID: <5EFF5DFC.2060006@mindspring.com>
Date: Fri, 03 Jul 2020 12:34:04 -0400
From: Michele Denber <denber@mindspring.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] configure / util: Auto-detect the availability of
 openpty()
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
 <5EFE5291.6030300@mindspring.com>
 <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
In-Reply-To: <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------080808010304010904020507"
X-ELNK-Trace: 17a948d2f1835c375e89bb4777695beb24867385ea7beca5dcec2dc719ac7d56b732be7bc5f70f84350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 8.9.81.230
Received-SPF: pass client-ip=209.86.89.68; envelope-from=denber@mindspring.com;
 helo=elasmtp-masked.atl.sa.earthlink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 12:34:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Tribble <peter.tribble@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------080808010304010904020507
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Oops, I hit Send before I was done.  I tried  the Haiku patch:

diff --git a/util/Makefile.objs b/util/Makefile.objs
index cc5e37177a..faebc13fac 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -39,7 +39,7 @@ util-obj-y += qsp.o
  util-obj-y += range.o
  util-obj-y += stats64.o
  util-obj-y += systemd.o
-util-obj-$(CONFIG_POSIX) += drm.o
+util-obj-$(CONFIG_LINUX) += drm.o
  util-obj-y += guest-random.o
  util-obj-$(CONFIG_GIO) += dbus.o
  dbus.o-cflags = $(GIO_CFLAGS)

but it didn't work:

root@hemlock:~/qemu-5.0.0# gpatch -p1 < Makefile.objs.patch.diff
patching file util/Makefile.objs
Hunk #1 FAILED at 39.
1 out of 1 hunk FAILED -- saving rejects to file util/Makefile.objs.rej
root@hemlock:~/qemu-5.0.0# cat util/Makefile.objs.rej
--- util/Makefile.objs
+++ util/Makefile.objs
@@ -39,7 +39,7 @@ util-obj-y += qsp.o
  util-obj-y += range.o
  util-obj-y += stats64.o
  util-obj-y += systemd.o
-util-obj-$(CONFIG_POSIX) += drm.o
+util-obj-$(CONFIG_LINUX) += drm.o
  util-obj-y += guest-random.o
  util-obj-$(CONFIG_GIO) += dbus.o
  dbus.o-cflags = $(GIO_CFLAGS)
root@hemlock:~/qemu-5.0.0#

             - Michele



--------------080808010304010904020507
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Oops, I hit Send before I was done.  I tried  the Haiku patch:<br>
    <br>
    <small><font face="Courier New, Courier, monospace">diff --git
        a/util/Makefile.objs b/util/Makefile.objs<br>
        index cc5e37177a..faebc13fac 100644<br>
        --- a/util/Makefile.objs<br>
        +++ b/util/Makefile.objs<br>
        @@ -39,7 +39,7 @@ util-obj-y += qsp.o<br>
         util-obj-y += range.o<br>
         util-obj-y += stats64.o<br>
         util-obj-y += systemd.o<br>
        -util-obj-$(CONFIG_POSIX) += drm.o<br>
        +util-obj-$(CONFIG_LINUX) += drm.o<br>
         util-obj-y += guest-random.o<br>
         util-obj-$(CONFIG_GIO) += dbus.o<br>
         dbus.o-cflags = $(GIO_CFLAGS)</font></small><br>
    <br>
    but it didn't work:<br>
    <br>
    <small><font face="Courier New, Courier, monospace"><a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a>
        gpatch -p1 &lt; Makefile.objs.patch.diff<br>
        patching file util/Makefile.objs<br>
        Hunk #1 FAILED at 39.<br>
        1 out of 1 hunk FAILED -- saving rejects to file
        util/Makefile.objs.rej<br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> cat util/Makefile.objs.rej<br>
        --- util/Makefile.objs<br>
        +++ util/Makefile.objs<br>
        @@ -39,7 +39,7 @@ util-obj-y += qsp.o<br>
         util-obj-y += range.o<br>
         util-obj-y += stats64.o<br>
         util-obj-y += systemd.o<br>
        -util-obj-$(CONFIG_POSIX) += drm.o<br>
        +util-obj-$(CONFIG_LINUX) += drm.o<br>
         util-obj-y += guest-random.o<br>
         util-obj-$(CONFIG_GIO) += dbus.o<br>
         dbus.o-cflags = $(GIO_CFLAGS)<br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> </font></small><br>
    <br>
                - Michele<br>
    <br>
    <br>
  </body>
</html>

--------------080808010304010904020507--

