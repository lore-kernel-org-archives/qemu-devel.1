Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F35C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 21:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9422081A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 21:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CiV+/HC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9422081A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joD4G-0005sL-OJ
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 17:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdenber@gmx.com>) id 1joCzv-0002o2-Vr
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 17:32:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:40777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdenber@gmx.com>) id 1joCzt-0006u8-NZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 17:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1593034314;
 bh=sddJ3Ijtnh1be6x+wStvTDUCEAFMLW5CFc6Qm7cXlQI=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=CiV+/HC3lkdsgeBZYqakn/yCn2bgDNPefR4Zt8STWDtIXmPEgkcrtH9BRVLaarOXq
 NFrpMrQikG2UZxDTIzVJvrzb8dNHivhCMqHAwTtXvj02YcsF3n13ttXG8BQYTSjbH1
 Xrb5i0g1lDy/FhqXNzYMJAboScFlUx5BLK0jDGCU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.78] ([8.9.81.230]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiPl-1jQo203fvJ-00U4Xv for
 <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 23:31:54 +0200
Message-ID: <5EF3C648.4060506@gmx.com>
Date: Wed, 24 Jun 2020 17:31:52 -0400
From: Michele Denber <mdenber@gmx.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: qemu-devel@nongnu.org
Subject: Building in Solaris 11.4
Content-Type: multipart/alternative;
 boundary="------------010704070801030301010603"
X-Provags-ID: V03:K1:i7wnlxrGw1BEy79uP1k+6k4omqn5ccHbf9Bdx9VuxBSQGjOwbfH
 m3jfyv9vu0dYqmN4Ot8iwJkiDIQvkQEhCJp8tUiI3Iszc7jxYiqrLDUR4XzYkwZA7IhiqZk
 UVjw7/P0wfGDE30qZAKw/7wi/EFePtWFf0z0taGlsM/h7OPMMQbOKZiAdaBrkeBWBHskOyf
 Xh0154XfDvFwoMlKn/5TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9LtDQjz3+Ow=:1bdk1nygR8YFx0xFFeJKGj
 jWJpEawnGuV6G0eupcIqFfj6pAfp9fDEkntYVFoYktRmnXPbI/xTyvaGMc29KLq6RKVZwbTAe
 S/p6sp7PL8dlfL5vlAgkLD9IuJNQcmhioUcUL9fCG1rC5XyR9HSGRCzQWvYCu5AR2do2E2yAT
 hMnVzeiyCK6eLpHnSwQNQy+3Zm9+tiYSIEMPq2hVpeGC7KSrtsIckA+e1+zH9Hvh4kDVqj+iw
 ZjS9taqKH+ukPCwspd2CEHxo7Uh+BSV7u0CsuXTS0nrCEVkrrLi5k9HLtjcgBQ6x6IiWpyGQi
 xV4VxZbtxxRlqPPYE/DnJrKEbbWoaeWOEbY7FTHXiP0YxsGk3lADuoLjSzTp9T4tCX/+gShlC
 lyMJh1e/vvJrwY/rGolRqTaD3avcjbmevYeSh32FTmzCVyJgWXjvYyWOs36yT8+xTWI37gMys
 mJMMjwsI3cAhLjCo5YaTBDwOFefhe5jdOJL3atdJLphGI1RmRvzbUy/o/NveRO7dA2EG1R9A7
 /553DwX7TwFUuBa90QBm5i/4hx7pqQZRQCgo9Ld3uZcB+/PP8L9LtFXxcQBWZBqophv8Uuq9q
 FlZ7ZZ64qk00vhw0yWWscOnWEGirgvrYJW3morpOh6kmQJIemLfVIY5iE3mGaXXWwsumcjV/o
 R1z/DdJWhvnaLJ8deAV44zF0WAoe4RHX6AweqACW7WB5RFe0AvGsiaElTq9STjfmmRF8U6AzG
 +Y48J+qgEyYX6JdGCUKbFANxIk78tVDEk6TplhocUs3cRXXToRWzTmljfsxKanNBDrQg3uDFE
 WV5RiTqPkw5QQunKpujdYEeiKQlFIkMX7UuwPJ4x56Z1b0L/KBivp0yrRgdJHS65vfy1PuQlE
 YM5uZdVfJ0gVdd9qBiOH1Ye+FoB8DQdU6WX249Tggr9Ik+H7LozIqGw+M2Hmx0cYzLv/Ny/Z7
 wcjLWgK7pO0/2WRTaxpjRcyI81Gg2ybNLBeIEdnSwC/N0qpdmaZYdA5eoWilDRdGXV5bxR8b6
 BvtE2byJtx23esoDBjt9DH8PmR6TNHcy0jWGeh7kNqj9aoclfmg2XcJsU9BVNeafevPZtc2j0
 OGo/3Z+aKRasERHzoQdhqhA8fzwg8EomJsnjz7dO5dKHAYJ5eEErwuuDoDH4EMlqlcJdSna3J
 nr47K+CwGCTXBiTz4iF3+7pcrHGtSkCRH27ymnCWBQW9KR4cbd8dmNZDFKaHL1i+v0MeQ=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=mdenber@gmx.com;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 17:31:54
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
--------------010704070801030301010603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

While trying to run configure in Solaris 11.4, I quickly run into:

root@hemlock:~/qemu-5.0.0# ./configure
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
./configure[62]: local: not found [No such file or directory]
grep: illegal option -- e
Usage: grep [-c|-l|-q] -bhinsvw pattern file . . .
./configure[62]: local: not found [No such file or directory]

ERROR: "cc" either does not exist or does not work

root@hemlock:~/qemu-5.0.0# gcc --version
gcc (GCC) 7.3.0
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
.

root@hemlock:~/qemu-5.0.0#

Line 62 is

     local compiler=3D"$1"

I'm not familiar with this construct.  What does "local" do?  It wasn't
in the configure file for QEMU 2.12.  (And I already said "cc=3Dgcc")

             - Michele


--------------010704070801030301010603
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    While trying to run configure in Solaris 11.4, I quickly run into:<br>
    <br>
    <small><font face="Courier New, Courier, monospace"><a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a>
        ./configure<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        grep: illegal option -- e<br>
        Usage: grep [-c|-l|-q] -bhinsvw pattern file . . .<br>
        ./configure[62]: local: not found [No such file or directory]<br>
        <br>
        ERROR: "cc" either does not exist or does not work<br>
        <br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> gcc --version<br>
        gcc (GCC) 7.3.0<br>
        Copyright (C) 2017 Free Software Foundation, Inc.<br>
        This is free software; see the source for copying conditions.&nbsp;
        There is NO<br>
        warranty; not even for MERCHANTABILITY or FITNESS FOR A
        PARTICULAR PURPOSE.<br>
        <br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> </font></small><br>
    <br>
    Line 62 is<br>
    <br>
    <small><font face="Courier New, Courier, monospace">&nbsp;&nbsp;&nbsp; local
        compiler="$1"</font></small><br>
    <br>
    I'm not familiar with this construct.&nbsp; What does "local" do?&nbsp; It
    wasn't in the configure file for QEMU 2.12.&nbsp; (And I already said
    "cc=gcc")<br>
    <br>
    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; - Michele<br>
    <br>
  </body>
</html>

--------------010704070801030301010603--

