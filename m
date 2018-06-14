Received: from eggs.gnu.org ([2001:4830:134:3::10]:36268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTRq6-0001rJ-Uh
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTRq3-0003tn-TX
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:58:59 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTRq3-0003tO-MV
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:58:55 -0400
Received: by mail-wr0-x243.google.com with SMTP id h10-v6so6316200wrq.8
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 05:58:55 -0700 (PDT)
References: <20180612062430.GA15344@xz-mi>
	<CAFEAcA_Bh4U1X_FDbakcc7YDBHFrkCjCKGrtuTWegn7rAGZUeQ@mail.gmail.com>
	<20180613040259.GI15344@xz-mi> <20180613092809.GF27901@redhat.com>
	<20180614025521.GR15344@xz-mi> <20180614081420.GG6355@redhat.com>
	<CAFEAcA-d8mVd2d7mAAVH6aWGHwyi=9yzKiwm2pX9unJ5OaACxg@mail.gmail.com>
	<20180614110322.GD14019@xz-mi>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180614110322.GD14019@xz-mi>
Date: Thu, 14 Jun 2018 13:58:53 +0100
Message-ID: <87y3fhzfqq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Is there a way to package QEMU binaries?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Devel Mailing List <qemu-devel@nongnu.org>


Peter Xu <peterx@redhat.com> writes:

> On Thu, Jun 14, 2018 at 11:50:23AM +0100, Peter Maydell wrote:
>> On 14 June 2018 at 09:14, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>> > On Thu, Jun 14, 2018 at 10:55:21AM +0800, Peter Xu wrote:
>> >> Then is there an easy way to port the specfile and tools to QEMU
>> >> repository so that we can pack that even with a git tree?
>>
>> > Well if we want to have a RPM spec file for QEMU distributed with upst=
ream
>> > QEMU, then I think it would be better todo what libvirt does[2], and s=
imply
>> > have the real Fedora  specfile kept in QEMU git [3].
>>
>> I would prefer not to. I think packaging is a job for downstream
>> distributors, and having our own (probably under-maintained)
>> version of the packaging infrastructure in upstream git just
>> makes things awkward for downstream, and requires us to make
>> choices about which distros we think "important" enough to
>> provide packaging for...
>
> AFAIU that's not a problem; we can just provide more ways to package
> the system gradually, just like what Linux did:
>
> Kernel packaging:
>   rpm-pkg             - Build both source and binary RPM kernel packages
>   binrpm-pkg          - Build only the binary kernel RPM package
>   deb-pkg             - Build both source and binary deb kernel packages
>   bindeb-pkg          - Build only the binary kernel deb package
>   snap-pkg            - Build only the binary kernel snap package (will c=
onnect to external hosts)
>   tar-pkg             - Build the kernel as an uncompressed tarball
>   targz-pkg           - Build the kernel as a gzip compressed tarball
>   tarbz2-pkg          - Build the kernel as a bzip2 compressed tarball
>   tarxz-pkg           - Build the kernel as a xz compressed tarball

I suspect the kernel is a special case as there aren't that many
dependencies or interactions to worry about. That said I think the make
install logic interfaces with some distro supplied hooks.

> But it seems that this package thing is not really that welcomed (and
> after all we have multiple specfiles here and there).  Then I think
> I'll just live with it now.

I could see an argument for hosting distro-agnostic packaging in the
QEMU source tree for things like snap or flatpak. However there is no
one uniform packaging approach for either deb or rpm based systems. They
all have their own rules and approaches to where things go that means
they are best served by the respective distributions.

>
> Regards,


--
Alex Benn=C3=A9e
