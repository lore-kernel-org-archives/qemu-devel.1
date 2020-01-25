Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59F5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 19:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E6F2071A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 19:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E6F2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=qindel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivQp7-0000jM-Tc
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 14:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <salvador@qindel.com>) id 1ivQoR-0008OO-1q
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 14:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <salvador@qindel.com>) id 1ivQoP-0001Zb-0O
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 14:09:42 -0500
Received: from smtp.qindel.com ([89.140.90.34]:36527 helo=thor.qindel.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <salvador@qindel.com>)
 id 1ivQoO-0001Pl-LT; Sat, 25 Jan 2020 14:09:40 -0500
Received: from localhost (localhost [127.0.0.1])
 by thor.qindel.com (Postfix) with ESMTP id 86DB76060B;
 Sat, 25 Jan 2020 20:09:35 +0100 (CET)
Received: from thor.qindel.com ([127.0.0.1])
 by localhost (thor.qindel.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 2eq5uY2aArGN; Sat, 25 Jan 2020 20:09:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by thor.qindel.com (Postfix) with ESMTP id 5416160619;
 Sat, 25 Jan 2020 20:09:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at thor.qindel.com
Received: from thor.qindel.com ([127.0.0.1])
 by localhost (thor.qindel.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id KaKFtQpjPQRm; Sat, 25 Jan 2020 20:09:35 +0100 (CET)
Received: from [192.168.20.140] (static.96.225.213.82.ibercom.com
 [82.213.225.96])
 by thor.qindel.com (Postfix) with ESMTPSA id F23D66060B;
 Sat, 25 Jan 2020 20:09:34 +0100 (CET)
Subject: Re: [PATCH] bsd-user: improve support for sparc syscall flags
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <157995335516.23531.17570150106723039473@f6d1ed32ca6b>
 <31af1372-1ef5-27b5-1530-5801aed19982@vivier.eu>
From: =?UTF-8?Q?Salvador_Fandi=c3=b1o?= <salvador@qindel.com>
Message-ID: <5c2ac6a7-97f6-c586-40ab-8be192435f16@qindel.com>
Date: Sat, 25 Jan 2020 20:09:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <31af1372-1ef5-27b5-1530-5801aed19982@vivier.eu>
Content-Type: multipart/alternative;
 boundary="------------246B9A9F366293DB841E3792"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 89.140.90.34
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
Cc: qemu-trivial@nongnu.org, sfandino@yahoo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------246B9A9F366293DB841E3792
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 25/1/20 16:52, Laurent Vivier wrote:
> Le 25/01/2020 =C3=A0 12:55, no-reply@patchew.org a =C3=A9crit=C2=A0:
>> Patchew URL: https://patchew.org/QEMU/20200125114753.61820-1-salvador@=
qindel.com/
>>
>>
>>
>> Hi,
>>
>> This series seems to have some coding style problems. See output below=
 for
>> more information:
>>
> Salvador,
>
> you can use scripts/checkpatch.pl in the QEMU directory to check your
> patch for style before sending them.
>
> And don't send them as a reply but as a new thread, using versioning in
> the subject ("[PATCH v4]").

ok, I will do that in the future.

In any case, the style problems found by patchew for the last version of=20
the patch I have submitted are for a fragment of a file copied verbatim=20
from the NetBSD source code (in the same way the equivalent fragment was=20
copied from OpenBSD when support for that OS was added). It is mostly=20
the copyright header and a few defines. IMO, style shouldn't be=20
corrected there.


--------------246B9A9F366293DB841E3792
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 25/1/20 16:52, Laurent Vivier wrote=
:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:31af1372-1ef5-27b5-1530-5801aed19982@vivier.eu">
      <pre class=3D"moz-quote-pre" wrap=3D"">Le 25/01/2020 =C3=A0 12:55, =
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:no-reply@patchew.org=
">no-reply@patchew.org</a> a =C3=A9crit=C2=A0:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">Patchew URL: <a class=3D"m=
oz-txt-link-freetext" href=3D"https://patchew.org/QEMU/20200125114753.618=
20-1-salvador@qindel.com/">https://patchew.org/QEMU/20200125114753.61820-=
1-salvador@qindel.com/</a>



Hi,

This series seems to have some coding style problems. See output below fo=
r
more information:

</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
Salvador,

you can use scripts/checkpatch.pl in the QEMU directory to check your
patch for style before sending them.

And don't send them as a reply but as a new thread, using versioning in
the subject ("[PATCH v4]").
</pre>
    </blockquote>
    <p><span style=3D"white-space: pre-wrap; display: block; width: 98vw;=
">
</span>ok, I will do that in the future.<br>
      <br>
      In any case, the style problems found by patchew for the last
      version of the patch I have submitted are for a fragment of a file
      copied verbatim from the NetBSD source code (in the same way the
      equivalent fragment was copied from OpenBSD when support for that
      OS was added). It is mostly the copyright header and a few
      defines. IMO, style shouldn't be corrected there.<br>
      <br>
    </p>
  </body>
</html>

--------------246B9A9F366293DB841E3792--

