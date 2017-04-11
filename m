Received: from eggs.gnu.org ([2001:4830:134:3::10]:45436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxvIE-0000ev-Ti
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxvIB-00062M-Rn
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:53:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cxvIB-000629-M1
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:53:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<20170327120148.GC26900@stefanha-x1.localdomain>
	<CAFEAcA_YVJKobjJ2WeEquxUdXVYeaCvA-K0+zumCc-Rm4Tk5nQ@mail.gmail.com>
	<20170403141912.GA3539@stefanha-x1.localdomain>
Date: Tue, 11 Apr 2017 14:53:00 +0200
In-Reply-To: <20170403141912.GA3539@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Mon, 3 Apr 2017 15:19:12 +0100")
Message-ID: <87fuhf9kcz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Mon, Mar 27, 2017 at 01:49:44PM +0100, Peter Maydell wrote:
>> On 27 March 2017 at 13:01, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> > It would be nice to get rid of the legacy -net option in 3.0.0.  I have
>> > added it and included pointers to loose ends.  I think this is doable
>> > but will require some time to achieve.
>> 
>> What's the syntax for using -netdev with embedded network
>> devices that you can't create with -device ?
>> (We should document this at
>> http://wiki.qemu-project.org/Documentation/Networking)
>
> I mentioned that on the wiki.  This isn't an option we can drop easily.
> Work is necessary to make -netdev a complete replacement or to remove
> the legacy stuff from -net.

Just like -device is a general way to plug in devices, replacing
multiple special ways (-net, -drive, -usb, ...), we could use a general
way to configure onboard devices.
