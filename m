Received: from eggs.gnu.org ([2001:4830:134:3::10]:48475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evJR8-0003AE-3S
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evJR3-0005hO-1t
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:08:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47048 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evJR2-0005b7-To
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:08:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CF128D6D7
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:07:55 +0000 (UTC)
References: <1520839658-20499-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a85941f-48bf-9e9b-0d6d-832a270d882b@redhat.com>
Date: Mon, 12 Mar 2018 10:07:43 +0100
MIME-Version: 1.0
In-Reply-To: <1520839658-20499-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

On 12/03/2018 08:27, Thomas Huth wrote:
> "-net" is clearly a legacy option. Yet we still use it in almost all
> examples in the qemu documentation, and many other spots in the network
> chapter. We should make it less prominent that users are not lured into
> using it so often anymore. So instead of starting the network chapter w=
ith
> "-net nic" and documenting "-net <backend>" below "-netdev <backend>"
> everywhere, all the "-net" related documentation is now moved to the en=
d
> of the chapter. The new "--nic" option is moved to the beginning of the
> chapter instead, with a new example that should demonstrate how "--nic"
> can be used to shortcut "--device" with "--netdev". The examples in thi=
s
> chapter are changed to use the "--device" and "--netdev" options or
> "--nic" instead of "-net nic -net <backend>".
>=20
> While we're at it, also remove a legacy remark about very old Linux
> distributions. Also remove the "[...]" from the examples in this chapte=
r
> since we are not using this ellipsis in any other examples in our docu-
> mentation.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Fixed the bad "--device=3De1000" example

Frankly I think this is the proof that double-dash option names are a
bad idea.  The reason to do that was to make qemu-img and qemu command
lines more similar in the documentation, but the truth is they are not
similar and shouldn't be made similar.  The equal sign is one example,
where qemu-img supports "--format=3Draw" but QEMU doesn't support
"--device=3De1000", but it's not the only one.

qemu-img supports things such as "-fraw", qemu doesn't---for example
"-m1024" doesn't work).  qemu-img can combine single-letter options
(e.g. "qemu-img convert -pc") but qemu cannot---e.g. "-sm" doesn't
combine "-s" and "-m".

No need to drop them in QEMU, since it's more or less just a convenience
for people that are used to double-dash long options, but using them in
the documentation is confusing.

Paolo

>  - Fixed some typos discovered by Eric
>  - Use --nic in even more examples (Paolo)
>  - Improved patch description
>  - Use single dash only in @findex tags (the appendix with the index lo=
oks
>    strange otherwise)
