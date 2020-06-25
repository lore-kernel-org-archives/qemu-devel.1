Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922D6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1A520789
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GUKrxhCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1A520789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWkD-0006so-Ae
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdenber@gmx.com>) id 1joWg1-0004wn-8p
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:32:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:48375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdenber@gmx.com>) id 1joWfz-0004FJ-07
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1593109958;
 bh=eErjgf1ZFT03E6KnoZMERdnsUazevRGlvWvGZEMFBfo=;
 h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
 b=GUKrxhCuUbHZaUXi9OpkXNtAp6HKBk6SPSJVNcH6YRedam8gW6D2nej8wIGZo6y/e
 9vATVxFZs7NSSRpvg/N446N0Qshnc5hOboRMiaAZUu2CfrP3uT7y2dLCdzHPGqEsjj
 h013Ay3SOve2g6mpuPy1EspBHERci8kN/Fr4Uj5k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.78] ([8.9.81.230]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MulqN-1iyLf31g0Z-00rmXq; Thu, 25
 Jun 2020 20:32:38 +0200
Message-ID: <5EF4EDC4.3030009@gmx.com>
Date: Thu, 25 Jun 2020 14:32:36 -0400
From: Michele Denber <mdenber@gmx.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: eblake@redhat.com, qemu-devel@nongnu.org
Subject: Re: Building in Solaris 11.4
References: <ae7652b5-86f7-fc52-af01-69096dd3b163@redhat.com>
 <5EF4D332.6040003@gmx.com>
In-Reply-To: <5EF4D332.6040003@gmx.com>
Content-Type: multipart/alternative;
 boundary="------------080106010809040705050807"
X-Provags-ID: V03:K1:8qUhtuFD4z0tO4SlUu3ua1M8YnjK8N1SaSON/DYJhhCEI6BxwPQ
 lIYTuvgvStKGWJdJAxzq2yRSI7sMmsXIZVpNJNg+hHTnV94eHZ/6kqCZqBrGqfDqVLH8Ykf
 cy3xgSB3sfdNRAFG89M6ea1BI2opTY9ij3UVvQYXCWHMwL6VrqybmIrTk/OlhxdQ7Ziyaab
 SdqAqSqipHM6rxtrZvylQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U++sgU/hy2w=:FjYulp4gjJ1oUP5uO914GD
 ctD8REf5lYJb1cHBKKcVm28rR2qw2xCPE+r1jq6chU411kikQZU9OkruQj5pC3iKFHckF83bJ
 VGCzdUeuGCtQU0Iw/rakF0poy62T50STNl1KrExPmf+flg0XNZmOFdL4fXrXBwTq1NGMS17kk
 xS3NXoL0rhM60m+QZ6dY4PJHOBUetmApK02v3ApUqRu+3xp5KkQn5k/GC5EXu4TosRB+NRkzM
 k4L5UeUlqSRYyLnYfugfLtp4Y7rqjS+7u2dVAY1xl6Dr8/H2g0t6a0shrkXzElbTqzmMBwJTf
 /mJGNPa9yLOnWupKidSMcARRa0KTMoeRGoKSpkk/gWxh1C48X6MGE7dbkbj8vtkBDoNGl8Fw4
 l+JTM5lYPvLJ+N1vaZXiKaaIuP7XCaOfHTRT7CfAMvxmBOFNrydwTPns7VA7AF2r66ZjcfQeY
 t9ta6wa4iB/+FdkVMpuGjJF+dT94G+Iq7lRmx3zkZ0M8aw8mlomtGLF94y4ZLC14dejURLjiq
 R1FRC2+yVByPSFta2m5LjvQSi9uW7h7ikwGYAdVZq8vPuW9UPAz0gaXyQMCnNfeMuPgqupeqd
 07DHYLoHcEPN+ZjF753eVKuYeFK0B1ZCMod18iKL53O/OVLM0RVPzChELjj0URyTl73iiTjl2
 q4J+2aK6cHkExXlD/VtfvVSwu8ShLyfstAPEdjfV953A9jNjroB8NW4dco7lbO7n31bGvHcmU
 yW+nvmPKIDqkLGu/SkP0UHwVheTFpDCk80k0dM5//hgBG9WKK9ILZMtmWXVO0NKHQiS4/rWoG
 1KOZdcMxMlaYPoNeX/YkvIJYNzecQYDnhyQdgnAEe0lAJg9QYU9QasCSAU0wrfkhZuuVr5HsN
 zoL+Devd932+O6CLLAKV1rq4DctTOPi9XrtNjuxupe+1huJGDNLj4bkqTGKyUxznMcFNsj7DO
 8s1CP5X45YNKGd/mWwIZICXqJx0xoAxZxIFWN1iJU9uMe5raO9FAHsG3N5zlYEmUoi8fOzstj
 zIY9aXaMPxC5YCkveJfNKqSx6hgWuKdln685MQA+EQA9FYrWC19Ewf6BJkLEx85NQeaA4LuG4
 hr9wYrPlxcMJE7xcB64PZ+0nMgyLJ1o8rbFb7pzrJCAw9kxNOVpJNIJTGShjkHd5C68YsJ3MN
 ZmKzr3nqLdtS4ayvnMZ8sF425DYeBhU2FXL2fHmCc3zoy+bG0QqEkNfXQ4lBXO4D3dP8C8gLy
 QsaAQ9lYQIqPbZUXw
Received-SPF: pass client-ip=212.227.17.21; envelope-from=mdenber@gmx.com;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 13:36:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------080106010809040705050807
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

Subject: 	Re: Building in Solaris 11.4
Date: 	Wed, 24 Jun 2020 16:48:51 -0500
From: 	Eric Blake <eblake@redhat.com>
Organization: 	Red Hat, Inc.
To: 	Michele Denber <mdenber@gmx.com>, qemu-devel@nongnu.org



>
> As a short-term workaround, you can always do:
>
> /path/to/bash ./configure
Ah yes, thank you.  I now recall having that problem building 2.12  in
Solaris 10 a few years ago.  The default bash in Solaris 11.4 is
/usr/bin/bash and that won't work.  I used /opt/csw/bin/bash instead and
that took care of the "local" problem.

Similarly, the default Solaris grep is missing the -e option so I
changed grep to ggrep in configure.  POSIX was always problematic in
Solaris because, I believe of Sun's efforts to maintain backward
compatibility.

So now I've got:

root@hemlock:~/qemu-5.0.0# /opt/csw/bin/bash ./configure --cc=3Dgcc

ERROR: sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T.
        You probably need to set PKG_CONFIG_LIBDIR
        to point to the right pkg-config files for your
        build target
root@hemlock:~/qemu-5.0.0#

I fixed that by saying

# LD_LIBRARY_PATH
=3D/usr/openwin/lib:opt/csw/lib:/usr/local/lib:/lib:/opt/sfw/lib:/opt/csw/=
gxx/lib:/usr/X11/lib
#
PKG_CONFIG_PATH=3D/opt/csw/lib/pkgconfig:/usr/local/lib/pkgconfig:/opt/sfw=
/lib/pkgconfig:/usr/lib/pkgconfig
#
PKG_CONFIG_LIBDIR=3D/opt/csw/lib/pkgconfig:/usr/local/lib/pkgconfig:/opt/s=
fw/lib/pkgconfig:/usr/lib/pkgconfig
# /opt/csw/bin/bash ./configure --cc=3Dgcc  --extra-cflags=3D"-m32"

(Thankfully I still have some notes from building QEMU 2.12.)

That gave me a successful configure ending with:

The QEMU project intends to remove support for this host OS in
a future release if nobody volunteers to maintain it and to
provide a build host for our continuous integration setup.
configure has succeeded and you can continue to build, but
if you care about QEMU on this platform you should contact
us upstream at qemu-devel@nongnu.org.

So I hereby volunteer.  I have an 8 core 64 thread 2.85 GHz. Sun T4-1
with 64 GB and three 900 GB disks and a 500 MB/50 MB fiber Internet
connection..

Anyway, that's enough for one day.  On to the gmake.  I'm sure I'll have
more questions soon :-)

             - Michele



--------------080106010809040705050807
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <table class=3D"moz-email-headers-table" cellpadding=3D"0"
      cellspacing=3D"0" border=3D"0">
      <tbody>
        <tr>
          <th nowrap=3D"nowrap" valign=3D"BASELINE" align=3D"RIGHT">Subjec=
t: </th>
          <td>Re: Building in Solaris 11.4</td>
        </tr>
        <tr>
          <th nowrap=3D"nowrap" valign=3D"BASELINE" align=3D"RIGHT">Date: =
</th>
          <td>Wed, 24 Jun 2020 16:48:51 -0500</td>
        </tr>
        <tr>
          <th nowrap=3D"nowrap" valign=3D"BASELINE" align=3D"RIGHT">From: =
</th>
          <td>Eric Blake <a class=3D"moz-txt-link-rfc2396E"
              href=3D"mailto:eblake@redhat.com">&lt;eblake@redhat.com&gt;<=
/a></td>
        </tr>
        <tr>
          <th nowrap=3D"nowrap" valign=3D"BASELINE" align=3D"RIGHT">Organi=
zation:

          </th>
          <td>Red Hat, Inc.</td>
        </tr>
        <tr>
          <th nowrap=3D"nowrap" valign=3D"BASELINE" align=3D"RIGHT">To: </=
th>
          <td>Michele Denber <a class=3D"moz-txt-link-rfc2396E"
              href=3D"mailto:mdenber@gmx.com">&lt;mdenber@gmx.com&gt;</a>,
            <a class=3D"moz-txt-link-abbreviated"
              href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org<=
/a></td>
        </tr>
      </tbody>
    </table>
    <br>
    <br>
    <blockquote cite=3D"mid:5EF4D332.6040003@gmx.com" type=3D"cite">
      <div class=3D"moz-forward-container">
        <pre>

As a short-term workaround, you can always do:

/path/to/bash ./configure</pre>
      </div>
    </blockquote>
    Ah yes, thank you.=A0 I now recall having that problem building 2.12=
=A0
    in Solaris 10 a few years ago.=A0 The default bash in Solaris 11.4 is
    /usr/bin/bash and that won't work.=A0 I used /opt/csw/bin/bash instead
    and that took care of the "local" problem.<br>
    <br>
    Similarly, the default Solaris grep is missing the -e option so I
    changed grep to ggrep in configure.=A0 POSIX was always problematic in
    Solaris because, I believe of Sun's efforts to maintain backward
    compatibility.<br>
    <br>
    So now I've got:<br>
    <small><font face=3D"Courier New, Courier, monospace"><br>
        <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:root@hemlock:=
~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> /opt/csw/bin/bash ./configur=
e
        --cc=3Dgcc<br>
        <br>
        ERROR: sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T.<br>
        =A0=A0=A0=A0=A0=A0 You probably need to set PKG_CONFIG_LIBDIR<br>
        =A0=A0=A0=A0=A0=A0 to point to the right pkg-config files for your=
<br>
        =A0=A0=A0=A0=A0=A0 build target<br>
        <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:root@hemlock:=
~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> </font></small><br>
    <br>
    I fixed that by saying<br>
    <small><font face=3D"Courier New, Courier, monospace"><br>
        # LD_LIBRARY_PATH
=3D/usr/openwin/lib:opt/csw/lib:/usr/local/lib:/lib:/opt/sfw/lib:/opt/csw/=
gxx/lib:/usr/X11/lib<br>
        #
PKG_CONFIG_PATH=3D/opt/csw/lib/pkgconfig:/usr/local/lib/pkgconfig:/opt/sfw=
/lib/pkgconfig:/usr/lib/pkgconfig<br>
        #
PKG_CONFIG_LIBDIR=3D/opt/csw/lib/pkgconfig:/usr/local/lib/pkgconfig:/opt/s=
fw/lib/pkgconfig:/usr/lib/pkgconfig</font></small><br>
    <small><font face=3D"Courier New, Courier, monospace">#
        /opt/csw/bin/bash ./configure --cc=3Dgcc=A0 --extra-cflags=3D"-m32=
"</font></small><br>
    <br>
    (Thankfully I still have some notes from building QEMU 2.12.)<br>
    <br>
    That gave me a successful configure ending with:<br>
    <br>
    <small><font face=3D"Courier New, Courier, monospace">The QEMU project
        intends to remove support for this host OS in<br>
        a future release if nobody volunteers to maintain it and to<br>
        provide a build host for our continuous integration setup.<br>
        configure has succeeded and you can continue to build, but<br>
        if you care about QEMU on this platform you should contact<br>
        us upstream at <a class=3D"moz-txt-link-abbreviated" href=3D"mailt=
o:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>.</font></small><br>
    <br>
    So I hereby volunteer.=A0 I have an 8 core 64 thread 2.85 GHz. Sun
    T4-1 with 64 GB and three 900 GB disks and a 500 MB/50 MB fiber
    Internet connection..<br>
    <br>
    Anyway, that's enough for one day.=A0 On to the gmake.=A0 I'm sure I'l=
l
    have more questions soon :-)<br>
    <br>
    =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 - Michele<br>
    <br>
    <br>
  </body>
</html>

--------------080106010809040705050807--

