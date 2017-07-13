Received: from eggs.gnu.org ([2001:4830:134:3::10]:39272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dVYGa-0003Cl-Rz
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dVYGX-0002BR-KP
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:10:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dVYGX-00028Y-CB
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:10:25 -0400
Received: by mail-wr0-f193.google.com with SMTP id k67so8387117wrc.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 00:10:22 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <87vamxzjln.fsf@dusky.pond.sub.org>
References: <cover.1499866456.git.alistair.francis@xilinx.com>
	<87vamxzjln.fsf@dusky.pond.sub.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 13 Jul 2017 09:08:50 +0200
Message-ID: <CAKmqyKN_qjQn_am2HK=yAEi0=AzkEMfxP4b8qvLOYwMkrCFYQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/7] Implement a warning_report function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, philippe@mathieu-daude.net, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Jul 12, 2017 at 6:49 PM, Markus Armbruster <armbru@redhat.com> wrote:
> Alistair Francis <alistair.francis@xilinx.com> writes:
>
>> QEMU currently has a standard method to report errors with
>> error_repot(). This ensure a sane and standard format when printing
>> errors. This series is attempting to extend this functionality for
>> warnings and information as well.
>>
>> This patch renames error_print_loc() function to be more clear, but I
>> didn't bother renaming the others. It seems silly to change
>> error_printf() to error_warning_printf() and printf is already taken so
>> I just left it as is.
>
> I can take this through my tree once PATCH 4 got some R-by from PC
> paintainers.  Whom you again neglected to cc; I just did that for you.
> I'll be happy to touch up minor issues like the ones I pointed out for
> v4.

Thanks for CCing them. I keep assuming git send-email will CC from the
suggested-by line, but apparently not.

Thanks,
Alistair
