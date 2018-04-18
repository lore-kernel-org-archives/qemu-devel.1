Received: from eggs.gnu.org ([2001:4830:134:3::10]:37458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8k9L-0000Q1-1b
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8k9H-0003nq-7K
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:17:15 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:38287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8k9H-0003nR-1T
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:17:11 -0400
Received: by mail-oi0-x231.google.com with SMTP id y20-v6so1075805oix.5
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 03:17:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180418101110.9563-1-berrange@redhat.com>
References: <20180418101110.9563-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Apr 2018 11:16:49 +0100
Message-ID: <CAFEAcA8Zxbp2XM5RjXK2yOYP2_cNnvANF6idPg4Hwqf9GR5P=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: add sanity check to catch
 builds from "git archive"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 April 2018 at 11:11, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:
> The "git archive" feature creates tarballs which are missing all
> submodule content. GitHub unhelpfully provides users with "Download"
> links that claim to give them valid source release tarballs. These
> GitHub archives will not be buildable as they are created by the
> "git archive" feature and so are missing content. The user gets
> unhelpful messages from make such as:
>
>   fatal error: ui/input-keymap-atset1-to-qcode.c: No such file or directo=
ry
>
> By adding a sanity check we can give users an informative message about
> what they've done wrong.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Is it worth also mentioning in the error message the
existence of scripts/archive-source.sh to help people
who need to create tarballs for their test setups
(the way we do internally for docker builds)?

thanks
-- PMM
