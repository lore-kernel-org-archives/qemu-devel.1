Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285B4C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 22:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94B02076E
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 22:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="UKOgxkNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94B02076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpIwi-0003Zt-8S
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 18:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jpIEU-0004T0-69
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 17:19:30 -0400
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:45580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jpIER-0007xT-UI
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 17:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
 s=dk12062016; t=1593292767; bh=Nt/ga6WK3hYs35VPZezS8RNXi8JQJjNApNGW
 8ZWaasU=; h=Received:Message-ID:Date:From:User-Agent:MIME-Version:
 To:Subject:Content-Type:X-ELNK-Trace:X-Originating-IP; b=UKOgxkNBX
 3hpFoVmbcQRsTeDEVpIElcyR1HktGvP20JqCC/OKE4ST6LMo23XgpiDzJsomaEkpBYC
 W5ATKrD//s6j0Nj8omyRq2oqJyBLhMvzai6FsLopbKK6VyiavQZ15uc6SgUltsS9EnR
 nAVihAsG9MME5rw2vFqUMjXlMyFaFBd9p/btRexwLgAw1iE9E8dPutbw8h4iH1WM3a1
 ovfnL4c7CnpRZlLAvCV5BkQE8CJO1RnqzuwweYgrz90A5PQD7kL9p5mP9SBKDFc5Tm6
 AW8VmwWk9t+6GlohpYnHLsypeRznDBrXKScpLPuV4O9xRkxaLxK99SlUu13+pjFQA==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
 s=dk12062016; d=mindspring.com;
 b=QeEI3GWNFj0pGve35Ib3ZTPvzcPPSZGZZgx/RzT9jsKzutSDj8e+gir9l8hcyt1z+upScolKeus18p2RICCSh/5Kt7IvwS+88vSrIjQKbHSqRg89J2HqxCMadlJ1ofO9TaXAftveaw9sd3mo/oC3YVMTkHnvvPDr9i5e2QhM4DoKm2HKLKvOOGvyFgBxtI2Atx0LTTqeS4EW21hoHJZ2qnV/xYolh4/rPio0N/iMv7uQ2lPNyCfB1qKTiDjApHMg0AeBOFshx6sevSHYC3PoGtFI3HDMTJkTAU92oxj30GPGGL9ZaBtgQnN7LnlXJep5lb5cbaChwuqWE2IG1E10CQ==;
 h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:Content-Type:X-ELNK-Trace:X-Originating-IP;
Received: from [8.9.81.230] (helo=[192.168.0.78])
 by elasmtp-dupuy.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <denber@mindspring.com>) id 1jpIEP-000Fso-3h
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 17:19:25 -0400
Message-ID: <5EF7B7DB.6040305@mindspring.com>
Date: Sat, 27 Jun 2020 17:19:23 -0400
From: Michele Denber <denber@mindspring.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: qemu-devel@nongnu.org
Subject: Re: Building in Solaris 11.4
Content-Type: multipart/alternative;
 boundary="------------090103030200070205000304"
X-ELNK-Trace: 17a948d2f1835c375e89bb4777695beb24867385ea7beca599a18933d8c46562103ef97afa792519350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 8.9.81.230
Received-SPF: pass client-ip=209.86.89.62; envelope-from=denber@mindspring.com;
 helo=elasmtp-dupuy.atl.sa.earthlink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 17:09:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 27 Jun 2020 18:02:26 -0400
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

This is a multi-part message in MIME format.
--------------090103030200070205000304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Well I removed the "static" from the line

static int openpty(int *amaster, int *aslave, char *name,
                    struct termios *termp, struct winsize *winp)

in util/qemu-openpty.c.  I odn't know if that was the right thing to do 
but it did allow it to compile.  Now I'm  stopped here:

...
CC      monitor/trace.o
util/drm.c: In function 'qemu_drm_rendernode_open':
util/drm.c:41:16: error: 'struct dirent' has no member named 'd_type'; 
did you mean 'd_name'?
          if (e->d_type != DT_CHR) {
                 ^~~~~~
                 d_name
util/drm.c:41:26: error: 'DT_CHR' undeclared (first use in this 
function); did you mean 'TH_CWR'?
          if (e->d_type != DT_CHR) {
                           ^~~~~~
                           TH_CWR
util/drm.c:41:26: note: each undeclared identifier is reported only once 
for each function it appears in
gmake: *** [/export/home/denber/qemu-5.0.0/rules.mak:69: util/drm.o] Error 1

This looks like more "not in Solaris" POSIX stuff.  See

https://stackoverflow.com/questions/35215109/struct-dirent-does-not-have-de-type-in-header-file

    "The only fields in the dirent structure that are mandated by
    POSIX.1 are: d_name[], of unspecified size, with at most NAME_MAX
    characters preceding the terminating null byte; and (as an XSI
    extension) d_ino. /The other fields are unstandardized, and not
    present on all systems/; see NOTES below for some further details.

    then continues

    Only the fields d_name and d_ino are specified in POSIX.1-2001. The
    remaining fields are available on many, but not all systems. Under
    glibc, programs can check for the availability of the fields not
    defined in POSIX.1 by testing whether the macros
    _DIRENT_HAVE_D_NAMLEN, _DIRENT_HAVE_D_RECLEN, _DIRENT_HAVE_D_OFF, or
    _DIRENT_HAVE_D_TYPE are defined.

    *Other than Linux, the d_type field is available mainly only on BSD
    systems.* This field makes it possible to avoid the expense of
    calling lstat(2) if further actions depend on the type of the file.
    If the _BSD_SOURCE feature test macro is defined, then glibc defines
    the following macro constants for the value returned in d_type:"

But I'm not sure what to make of this.


             - Michele



--------------090103030200070205000304
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Well I removed the "static" from the line<br>
    <br>
    <small><font face="Courier New, Courier, monospace">static int
        openpty(int *amaster, int *aslave, char *name,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct termios *termp, struct winsize *winp)</font></small><br>
    <br>
    in util/qemu-openpty.c.&nbsp; I odn't know if that was the right thing to
    do but it did allow it to compile.&nbsp; Now I'm&nbsp; stopped here:<br>
    <small><font face="Courier New, Courier, monospace"><br>
        ...<br>
        CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; monitor/trace.o<br>
        util/drm.c: In function 'qemu_drm_rendernode_open':<br>
        util/drm.c:41:16: error: 'struct dirent' has no member named
        'd_type'; did you mean 'd_name'?<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (e-&gt;d_type != DT_CHR) {<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d_name<br>
        util/drm.c:41:26: error: 'DT_CHR' undeclared (first use in this
        function); did you mean 'TH_CWR'?<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (e-&gt;d_type != DT_CHR) {<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TH_CWR<br>
        util/drm.c:41:26: note: each undeclared identifier is reported
        only once for each function it appears in<br>
        gmake: *** [/export/home/denber/qemu-5.0.0/rules.mak:69:
        util/drm.o] Error 1</font></small><br>
    <br>
    This looks like more "not in Solaris" POSIX stuff.&nbsp; See<br>
    <br>
    <small><font face="Courier New, Courier, monospace"><a class="moz-txt-link-freetext" href="https://stackoverflow.com/questions/35215109/struct-dirent-does-not-have-de-type-in-header-file">https://stackoverflow.com/questions/35215109/struct-dirent-does-not-have-de-type-in-header-file</a></font></small><br>
    <blockquote><small></small>
      <p><small>"The only fields in the dirent structure that are
          mandated by POSIX.1 are: d_name[], of unspecified size, with
          at most NAME_MAX characters preceding the terminating null
          byte; and (as an XSI extension) d_ino. <em>The other fields
            are unstandardized, and not present on all systems</em>; see
          NOTES below for some further details.</small></p>
      <small>
      </small>
      <p><small>then continues</small></p>
      <p><small>Only the fields d_name and d_ino are specified in
          POSIX.1-2001. The remaining fields are available on many, but
          not all systems. Under glibc, programs can check for the
          availability of the fields not defined in POSIX.1 by testing
          whether the macros _DIRENT_HAVE_D_NAMLEN,
          _DIRENT_HAVE_D_RECLEN, _DIRENT_HAVE_D_OFF, or
          _DIRENT_HAVE_D_TYPE are defined.</small></p>
      <p><small><b>Other than Linux, the d_type field is available
            mainly only on BSD systems.</b> This field makes it possible
          to avoid the expense of calling lstat(2) if further actions
          depend on the type of the file. If the _BSD_SOURCE feature
          test macro is defined, then glibc defines the following macro
          constants for the value returned in d_type:"</small><br>
      </p>
    </blockquote>
    <blockquote>
    </blockquote>
    <p>But I'm not sure what to make of this.<br>
    </p>
    <blockquote>
    </blockquote>
    <br>
    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; - Michele<br>
    <br>
    <br>
  </body>
</html>

--------------090103030200070205000304--

