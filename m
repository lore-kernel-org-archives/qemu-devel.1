Received: from eggs.gnu.org ([2001:4830:134:3::10]:42968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhUbf-0001EP-Ds
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 01:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhUba-0000Ui-Hu
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 01:41:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhUba-0000UN-Bx
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 01:41:30 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
	<13edc53da08b5fb065eccb8f658bad0526a252b1.1501280035.git.alistair.francis@xilinx.com>
	<87zib2wa24.fsf@dusky.pond.sub.org>
	<CAKmqyKP0+V++zL+-O=D0wqhh=bOFyq3XY=o4pP_jb98iPLdU7g@mail.gmail.com>
Date: Tue, 15 Aug 2017 07:41:21 +0200
In-Reply-To: <CAKmqyKP0+V++zL+-O=D0wqhh=bOFyq3XY=o4pP_jb98iPLdU7g@mail.gmail.com>
	(Alistair Francis's message of "Mon, 14 Aug 2017 11:48:20 -0700")
Message-ID: <87k225wfpa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/5] Convert multi-line fprintf() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Igor Mammedov <imammedo@redhat.com>, Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

Alistair Francis <alistair.francis@xilinx.com> writes:

> On Mon, Aug 14, 2017 at 6:30 AM, Markus Armbruster <armbru@redhat.com> wrote:
[...]
>> Drop the periods from the warning messages, and you may add
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>> I encourage you to also use the opportunity to improve line breaks.
>>
>> I'm not asking you to fix the other issues with the messages.
>
> I'm happy to fix them. Do you want them fixed in this commit or split
> into a seperate commit?

Separate would keep this one mostly mechanical.  Announcing the followup
work in the commit message would help reviewers.  Something like
"several warning messages could use improvement; will be addressed
shortly".
