Received: from eggs.gnu.org ([2001:4830:134:3::10]:51734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fIzlh-0000wM-E6
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fIzld-0005yA-H2
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:59:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fIzld-0005y0-Bp
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:59:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1C4E81663DC
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 16:59:08 +0000 (UTC)
References: <1525453270-23074-1-git-send-email-thuth@redhat.com>
	<f7756c7c-338a-a719-7135-aa7a53a62c4c@redhat.com>
	<87wowgyqj8.fsf@dusky.pond.sub.org>
	<32c5b770-3bbf-e9d2-ea78-023986ba828f@redhat.com>
	<87sh73yk3z.fsf@dusky.pond.sub.org>
	<ff5d2f93-8629-bc78-73a5-c3af38409647@redhat.com>
	<87tvrjvfuf.fsf@dusky.pond.sub.org>
	<c8ed2b21-2440-177f-1d25-f20ebdc840d3@redhat.com>
	<87d0y7tno1.fsf@dusky.pond.sub.org>
	<0568aa4f-2933-348d-416a-d8b97ac2dd87@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0b107272-6d57-0a0f-c221-ba9aeb50dd98@redhat.com>
Date: Wed, 16 May 2018 18:59:03 +0200
MIME-Version: 1.0
In-Reply-To: <0568aa4f-2933-348d-416a-d8b97ac2dd87@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com

On 07.05.2018 19:01, Paolo Bonzini wrote:
> On 07/05/2018 18:50, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> On 07/05/2018 13:56, Markus Armbruster wrote:
>>>> Adding more and more ways to do the same stuff does not improve an
>>>> interface.  Interface design needs to be *opinionated*.  If we decid=
e
>>>> -machine accel=3Dtcg isn't a nice interface, by all means create a b=
etter
>>>> one, but as replacement[*], not as addition.
>>>>
>>>> Furthermore:
>>>>
>>>>     tcg: add options for enabling MTTCG
>>>>
>>>>     We know there will be cases where MTTCG won't work until additio=
nal work
>>>>     is done in the front/back ends to support. It will however be us=
eful to
>>>>     be able to turn it on.
>>>>
>>>>     As a result MTTCG will default to off unless the combination is
>>>>     supported. However the user can turn it on for the sake of testi=
ng.
>>>>
>>>>     Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
>>>>     [AJB: move to -accel tcg,thread=3Dmulti|single, defaults]
>>>>     Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>     Reviewed-by: Richard Henderson <rth@twiddle.net>
>>>>
>>>> I'm sorry, but this us sub-par.  Yes, the commit is also about "enab=
ling
>>>> MTTCG", but it also adds a new way to select accelerators, without e=
ver
>>>> spelling that out.  It should've been split, and properly described.
>>>
>>> Perhaps we can deprecate "-M accel" then, and also while we're at it
>>> move kernel_irqchip from -machine to "-accel kvm" where it belongs?
>>
>> Sounds good to me.
>=20
> Thomas, here's one for you! :)

I like the idea of deprecating "-machine accel=3Dxxx" - but that will als=
o
be a bigger change, since "-accel" is internally setting the accel
option of the machine again...

Also libvirt is still using "-machine accel=3D..." as far as I know, so
we've got to make sure that this gets changed there, too...

 Thomas
