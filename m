Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139F6C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34E320878
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdaNFX6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34E320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWzEj-0007x1-0e
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 03:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWzE5-0007Rp-EF
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWzE2-0001Q7-86
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:51:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35033
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWzE2-0001Pp-4h
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574153465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CczLV09iKD4aLxtz2/ywTzTYGw0hJAYIJM6eUhi4yW4=;
 b=PdaNFX6/AWTkyQhGDfsdMB75EFDGrfvPKiHBTZmoeecRvXbioB/O4Xoqe21Ikb+oxESuj9
 i5t2R3pL4cDLZ7FK+WMKN9k3eLCJqa+76+vnayp8tINETmq7fN/M8f5Y2SKMwGANtOq3cS
 5pmODCLWeFkUVYkvijiRyT4JkghFu8g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-xfredVy_MUGdUyE3o5LibA-1; Tue, 19 Nov 2019 03:51:03 -0500
Received: by mail-wm1-f72.google.com with SMTP id y14so2057163wmi.4
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 00:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QCVPJn3vzbNqj86wHiCCIYdkrkhcCMR8A+0CTluzjlg=;
 b=i6TlYrD2bckCvCvRkDszxoxPB7ajSS2r6WzmfN328h4VaxjzDiN/M0xsadsjxrCKf0
 CqH7xJGdqOKs/EHHf95gkbMPSBOJ/1cdJBEw242PWfuUUog3pE1FjyxlbDYWEGPl2R8v
 6vU3GrlgeBGlHtuueH5uom/ne/rceL3bxvr8TQW/Xtz8ARcq1WQP4y3TVQSWNa98291o
 tpnIK2+aZOfnFUPo3kfV0YfUvu7lGornkwUvVzxHooPFWoXte/rGkjT+F+V3RH4YjxT3
 FAE7STJg+lwA5QHJDBva/TqesgSoojyXlTQU+MGn06rYeNu14dk7EWC0Z+eHO05iKHKN
 Q3YQ==
X-Gm-Message-State: APjAAAVQeKop0RVQmodACVpe1P824OJvtvbVH69dXSkEEawyR1V+ApYM
 jiGeYdpBp2ZqG1Ub7MdGRFOtG3IkW/nF8g9xr+pvEWTidWg5E/QzQn/kCpunao7Ko7Z5cKvk6av
 zLHF9ckVZsqEnRZI=
X-Received: by 2002:a1c:22c6:: with SMTP id i189mr4341540wmi.51.1574153462026; 
 Tue, 19 Nov 2019 00:51:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqySsnJvYpm5KgH65Y9jnFXN8TAlKejjh8T5V3ce90oieiaSWgX+fxr4YCkvEaeGR2iUcRoLKg==
X-Received: by 2002:a1c:22c6:: with SMTP id i189mr4341509wmi.51.1574153461790; 
 Tue, 19 Nov 2019 00:51:01 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id o1sm26476146wrs.50.2019.11.19.00.51.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 00:51:01 -0800 (PST)
Subject: Exclude paths from checkpatch (was: Re: [PATCH] Add minimal Hexagon
 target)
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
References: <157412709300.27250.5531224491109755641@37313f22b938>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7851e556-a5f2-9059-faf7-3d2a4e32958c@redhat.com>
Date: Tue, 19 Nov 2019 09:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157412709300.27250.5531224491109755641@37313f22b938>
Content-Language: en-US
X-MC-Unique: xfredVy_MUGdUyE3o5LibA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, tsimpson@quicinc.com, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 2:31 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/1574121497-2433-1-git-send-email-ts=
impson@quicinc.com/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below fo=
r
> more information:
>=20
> Subject: [PATCH] Add minimal Hexagon target - First in a series of patche=
s - linux-user changes + linux-user/hexagon + skeleton of target/hexagon - =
Files in target/hexagon/imported are from another project and therefore do =
not conform to qemu coding standards
> Type: series
> Message-id: 1574121497-2433-1-git-send-email-tsimpson@quicinc.com
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Switched to a new branch 'test'
> 7744509 Add minimal Hexagon target - First in a series of patches - linux=
-user changes + linux-user/hexagon + skeleton of target/hexagon - Files in =
target/hexagon/imported are from another project and therefore do not confo=
rm to qemu coding standards
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #38:
> new file mode 100644
>=20
> ERROR: do not use C99 // comments
> #1922: FILE: target/hexagon/imported/iss_ver_registers.h:80:
> +// New interrupts, keep old defines for the time being

I tried this quick way to filter some file/directory out of=20
checkpatch.pl, and it works nicely:

$ cat .git/hooks/pre-commit
#!/bin/bash
exec git diff --cached -- ':(top)' $(test -e .checkpatchignore && sed=20
-ne '/^\(#.*\|$\)/ ! s/.*/:(exclude)\0/p' < .checkpatchignore) |=20
scripts/checkpatch.pl --no-signoff -q -

$ cat .checkpatchignore
# A line starting with # serves as a comment.
# A blank line matches no files, so it can serve as a separator for=20
readability.
include/standard-headers
target/xtensa/core-*
target/hexagon/imported

Would this be acceptable to reduce patchew false positives?

git exclude pathspec trick from:
https://stackoverflow.com/questions/39931781/git-diff-stat-exclude-certain-=
files/39937070#39937070


