Received: from eggs.gnu.org ([2001:4830:134:3::10]:50182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dQFeY-0003rR-Dz
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 12:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dQFeX-0002gK-BL
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 12:17:18 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dQFeX-0002g0-54
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 12:17:17 -0400
Received: by mail-wm0-x244.google.com with SMTP id p204so7605820wmg.1
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 09:17:17 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170628090448.GE29134@redhat.com>
References: <cover.1498596157.git.alistair.francis@xilinx.com>
	<4e1eded5cda7b182a8a4cb133b40b2915817b7d1.1498596157.git.alistair.francis@xilinx.com>
	<20170628090448.GE29134@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 28 Jun 2017 09:16:45 -0700
Message-ID: <CAKmqyKNEgZPMdS5B4J09XVpDQt0LXw0YFbMdBa_fnBXmnndftA@mail.gmail.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Wed, Jun 28, 2017 at 2:04 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Tue, Jun 27, 2017 at 01:45:45PM -0700, Alistair Francis wrote:
>> Add a functino which can be used similarly to error_report() execpt to
>> inform the users about warnings instead of errors.
>>
>> The warning print does not include the timestamp and instead will
>> preface the messages with a 'warning: '.
>
> Not including the timestamp is a bug IMHO. If I've turned on timestamps,
> I expect all messages to have the timestamp.

That's fine, I'm happy to add it back in. I just wasn't sure.

>
> I'm not particularly convinced by adding the 'warning: ' prefix either,
> particularly given the scenario you are using this in, is not actually
> a warning - its just a informative message.

Maybe it makes more sense to add an extra argument to error_report()
that can be used to specify error, warning or information. The same
way qemu_log_mask() works. That was Edgar's idea in reply to one of
the other patches.

Does that sound more useful?

Thanks,
Alistair

>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
