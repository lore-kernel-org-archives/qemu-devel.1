Received: from eggs.gnu.org ([2001:4830:134:3::10]:50212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dQ0fJ-0003bN-T2
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 20:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dQ0fJ-0003wL-2q
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 20:17:05 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dQ0fI-0003vr-SW
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 20:17:05 -0400
Received: by mail-wm0-x234.google.com with SMTP id 62so38653912wmw.1
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 17:17:03 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <df67b0cd-0b49-c0c1-fa7b-3928204e7c0b@redhat.com>
References: <cover.1498596157.git.alistair.francis@xilinx.com>
	<4e1eded5cda7b182a8a4cb133b40b2915817b7d1.1498596157.git.alistair.francis@xilinx.com>
	<df67b0cd-0b49-c0c1-fa7b-3928204e7c0b@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 27 Jun 2017 17:16:31 -0700
Message-ID: <CAKmqyKMbJ1R3T0cq2j8uCUKx2jYhrW5uCEm-V6DufDW=NYb=WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v1 2/3] util/qemu-error: Add a
 warning_report() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Tue, Jun 27, 2017 at 3:21 PM, Thomas Huth <thuth@redhat.com> wrote:
> On 27.06.2017 22:45, Alistair Francis wrote:
>> Add a functino which can be used similarly to error_report() execpt to
>> inform the users about warnings instead of errors.
>
> s/functino/function/
> s/execpt/except/

Thanks, I'll fix these two in the next version.

>
> And could we maybe call the function "warn_report" or something else
> instead? I often already have trouble with error_report() to fit the
> string into one line of the scarce 80 columns space ... so the shorter
> the name of the function, the more characters can be squeezed into the
> string in one line later ;-)

Good idea, I'll change it to warn_report().

Thanks,
Alistair

>
>  Thomas
