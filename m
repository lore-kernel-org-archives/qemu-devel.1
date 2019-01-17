Received: from eggs.gnu.org ([209.51.188.92]:41235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gk8At-0004vv-38
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gk8As-0007YI-22
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:57:39 -0500
Received: from mail-yw1-xc36.google.com ([2607:f8b0:4864:20::c36]:40727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makren67@gmail.com>) id 1gk8Ar-0007QT-UG
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:57:38 -0500
Received: by mail-yw1-xc36.google.com with SMTP id g194so3838797ywe.7
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 05:57:37 -0800 (PST)
MIME-Version: 1.0
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
	<CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
	<CAJSP0QXAz3W=qi96EL6vCn187j0QUtjGLKwVk5wWTST40h+JMg@mail.gmail.com>
In-Reply-To: <CAJSP0QXAz3W=qi96EL6vCn187j0QUtjGLKwVk5wWTST40h+JMg@mail.gmail.com>
From: Nick Renieris <makren67@gmail.com>
Date: Thu, 17 Jan 2019 15:57:08 +0200
Message-ID: <CAObpvQkbk4j+zOz4VDeKwRc8=UqRw3aK4=0yWabS0gvBTDzBwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] AVX support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

Thanks Stefan,

Just a heads up, I don't know if I want to go for this myself yet.
I'm still not sure I'll even be able to deliver the refactoring in
time (Step 2 in your list), and I hadn't even considered tests for SSE
as something I'd have to do since they're already implemented.
In addition, there's been talks with a different project that I might apply=
 for.
I'll keep in touch if that changes, of course.

Cheers,
Nick Renieris.

=CE=A3=CF=84=CE=B9=CF=82 =CE=A0=CE=AD=CE=BC, 17 =CE=99=CE=B1=CE=BD 2019 =CF=
=83=CF=84=CE=B9=CF=82 11:29 =CF=80.=CE=BC., =CE=BF/=CE=B7 Stefan Hajnoczi
<stefanha@gmail.com> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
>
> On Wed, Dec 26, 2018 at 1:29 AM Nick Renieris <makren67@gmail.com> wrote:
> > Do you think this could work as a GSoC project? I'm potentially
> > interested in working on it this summer.
>
> Richard and Nick,
> You are welcome to create a GSoC project idea and post it here:
> https://wiki.qemu.org/Google_Summer_of_Code_2019
>
> Good project ideas have the following characteristics:
>  * Well-defined - the scope is clear
>  * Self-contained - there are few dependencies
>  * Uncontroversial - they are acceptable to the community
>  * Incremental - they produce deliverables along the way
>
> Can you break down the project into tasks?
> 1. Test cases for SSE and AVX
> 2. SSE refactoring that needs to be done first
> 3. AVX instructions that will be covered
> 4. Stretch goals (AVX2, AVX512, etc)
>
> The project idea template looks like this:
>
> =3D=3D=3D TITLE =3D=3D=3D
>
>  '''Summary:''' Short description of the project
>
>  Detailed description of the project.
>
>  '''Links:'''
>  * Wiki links to relevant material
>  * External links to mailing lists or web sites
>
>  '''Details:'''
>  * Skill level: beginner or intermediate or advanced
>  * Language: C
>  * Mentor: Email address and IRC nick
>  * Suggested by: Person who suggested the idea
>
>
> Note that project ideas are open to all applicants in order to ensure fai=
rness.
>
> Stefan
