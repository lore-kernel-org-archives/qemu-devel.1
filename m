Received: from eggs.gnu.org ([2001:4830:134:3::10]:42185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cmIdc-000375-Nk
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cmIdb-00054Q-NS
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:23:12 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cmIdb-00054B-EK
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:23:11 -0500
Received: by mail-wm0-x233.google.com with SMTP id t189so8240720wmt.1
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 03:23:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1aeb7375-d41f-1be4-cbb5-d7bd27801110@redhat.com>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<CAFEAcA9cM=LjBRzrZdfsOss2xm4bKC6QM7gyg3HD4z-yeumTyw@mail.gmail.com>
	<940ff281-82cd-18cf-160e-c5234f65db18@redhat.com>
	<9d6c61bc-4a95-ce72-3565-e498f9c2b351@redhat.com>
	<b815c2f9-1ce9-efed-4afa-c3553786dab1@redhat.com>
	<16223ebe-e08d-c686-7ff3-a58db88e3a01@redhat.com>
	<d897339f-9451-d350-6fd5-72c68a2da677@imgtec.com>
	<1aeb7375-d41f-1be4-cbb5-d7bd27801110@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Mar 2017 12:22:49 +0100
Message-ID: <CAFEAcA9x1c74MBetKxxwQSNWhC=C8JV80QCBiEuY3pLteY=UVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 10 March 2017 at 12:07, Jason Wang <jasowang@redhat.com> wrote:
> On 2017=E5=B9=B403=E6=9C=8809=E6=97=A5 18:20, Yongbok Kim wrote:
>> Indeed but we still use the platform to verify architectural
>> compatibilities even for newer MIPS architectures.

> I see, but I believe it may need some modifications in the code to suppor=
t
> newer architectures? If yes, plan to send them upstream? Since it has bee=
n
> deprecated, if no new codes it makes sense to deprecate it in qemu too. Y=
ou
> can still use exist qemu versions to do the verification.

Taking a step back, the reason for deprecating and deleting
code is to avoid having unmaintained and unused code in QEMU.
If Yongbok is maintaining the mipssim board and devices
and is willing to keep them up to spec with current QOM
and other best practices, and there are test images to
check they still work, I think that's fine.

thanks
-- PMM
