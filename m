Received: from eggs.gnu.org ([2001:4830:134:3::10]:53847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fFfVb-0004CK-Py
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fFfVX-0006Ey-LF
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:44:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fFfVX-0006Eh-G7
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:44:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0788F4077EF9
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 12:44:47 +0000 (UTC)
References: <1525453270-23074-1-git-send-email-thuth@redhat.com>
	<f7756c7c-338a-a719-7135-aa7a53a62c4c@redhat.com>
	<87wowgyqj8.fsf@dusky.pond.sub.org>
	<32c5b770-3bbf-e9d2-ea78-023986ba828f@redhat.com>
	<87sh73yk3z.fsf@dusky.pond.sub.org>
	<ff5d2f93-8629-bc78-73a5-c3af38409647@redhat.com>
	<87tvrjvfuf.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c8ed2b21-2440-177f-1d25-f20ebdc840d3@redhat.com>
Date: Mon, 7 May 2018 14:44:42 +0200
MIME-Version: 1.0
In-Reply-To: <87tvrjvfuf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Removal of deprecated -no-kvm*
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 07/05/2018 13:56, Markus Armbruster wrote:
> Adding more and more ways to do the same stuff does not improve an
> interface.  Interface design needs to be *opinionated*.  If we decide
> -machine accel=3Dtcg isn't a nice interface, by all means create a bett=
er
> one, but as replacement[*], not as addition.
>=20
> Furthermore:
>=20
>     tcg: add options for enabling MTTCG
>=20
>     We know there will be cases where MTTCG won't work until additional=
 work
>     is done in the front/back ends to support. It will however be usefu=
l to
>     be able to turn it on.
>=20
>     As a result MTTCG will default to off unless the combination is
>     supported. However the user can turn it on for the sake of testing.
>=20
>     Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
>     [AJB: move to -accel tcg,thread=3Dmulti|single, defaults]
>     Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>     Reviewed-by: Richard Henderson <rth@twiddle.net>
>=20
> I'm sorry, but this us sub-par.  Yes, the commit is also about "enablin=
g
> MTTCG", but it also adds a new way to select accelerators, without ever
> spelling that out.  It should've been split, and properly described.

Perhaps we can deprecate "-M accel" then, and also while we're at it
move kernel_irqchip from -machine to "-accel kvm" where it belongs?

Paolo
