Received: from eggs.gnu.org ([2001:4830:134:3::10]:41607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dQFEO-0006NG-3N
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dQFEN-0007EB-4q
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:50:16 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dQFEM-0007Do-UM
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:50:15 -0400
Received: by mail-wm0-x243.google.com with SMTP id 131so12266792wmq.2
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 08:50:14 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170628090746.GF29134@redhat.com>
References: <cover.1498596157.git.alistair.francis@xilinx.com>
	<20170628090746.GF29134@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 28 Jun 2017 08:49:43 -0700
Message-ID: <CAKmqyKMnH9WF1RALQqJz5pBnE1g1BP=Bk0bt7pYD5VsyXunLfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v1 0/3] Implement a warning_report function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Wed, Jun 28, 2017 at 2:07 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Tue, Jun 27, 2017 at 01:45:41PM -0700, Alistair Francis wrote:
>> QEMU currently has a standard method to report errors with
>> error_repot(). This ensure a sane and standard format when printing
>> errors. This series is attempting to add the same functionality for
>> warnings.
>
> I'm not seeing the obvious benefit in this change. Despite its name
> 'error_report' is ultimately just a clever way to run printf()
> on a text string. It can be used for errors, warnings, information
> alike. If anything the current method is simply misnamed, and could
> be changed to 'message_report'.

I agree that this new method results in the same information being
printed to the same place as error_report(). What I am trying to
achieve though is a consistent structure for messages. So that every
error, warning and information message that QEMU prints looks the same
and are all obvious. The final end goal is that when including QEMU in
other systems (like an Eclipse GUI) all of the different messages can
be clearly understood and automatically parsed.

The problem I think we have now is that some messages just showing
information to the user (like in patch 3) are treated the same as
errors, when they really are not errors. I have seen a lot of
confusion caused by QEMU printing errors and information to stderr
with no obvious way to differentiate which is which.

Thanks,
Alistair

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
