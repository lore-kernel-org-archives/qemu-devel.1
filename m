Received: from eggs.gnu.org ([2001:4830:134:3::10]:50764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csU64-0001bX-45
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csU62-0000LQ-Qi
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:50:08 -0400
Received: from mail-lf0-x233.google.com ([2a00:1450:4010:c07::233]:33814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csU62-0000L3-K1
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:50:06 -0400
Received: by mail-lf0-x233.google.com with SMTP id z15so20292700lfd.1
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 05:50:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170327120148.GC26900@stefanha-x1.localdomain>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<20170327120148.GC26900@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Mar 2017 13:49:44 +0100
Message-ID: <CAFEAcA_YVJKobjJ2WeEquxUdXVYeaCvA-K0+zumCc-Rm4Tk5nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 27 March 2017 at 13:01, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> It would be nice to get rid of the legacy -net option in 3.0.0.  I have
> added it and included pointers to loose ends.  I think this is doable
> but will require some time to achieve.

What's the syntax for using -netdev with embedded network
devices that you can't create with -device ?
(We should document this at
http://wiki.qemu-project.org/Documentation/Networking)

thanks
-- PMM
