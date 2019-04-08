Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C9BC282DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 06:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C639B2084F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 06:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C639B2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48196 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDNnG-0001Cg-1T
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 02:30:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDNmO-0000oX-ID
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDNmN-0006wx-7O
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:29:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hDNmM-0006wZ-U4; Mon, 08 Apr 2019 02:29:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C064B2D7E0;
	Mon,  8 Apr 2019 06:29:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A17045D717;
	Mon,  8 Apr 2019 06:29:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 142FA1138648; Mon,  8 Apr 2019 08:29:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
References: <20190404071421.4891-1-thuth@redhat.com>
	<298ccbd7-9af5-8303-e42b-33dd1cb94b9e@redhat.com>
	<158fe22a-5781-73e5-5955-2fe9db019236@redhat.com>
	<3ba3c765-589f-4c0a-38dc-d9126f515e7b@redhat.com>
	<87lg0p4tsc.fsf@dusky.pond.sub.org>
	<8e8d5b15-57ad-95ff-c328-557c617d93b6@redhat.com>
Date: Mon, 08 Apr 2019 08:29:07 +0200
In-Reply-To: <8e8d5b15-57ad-95ff-c328-557c617d93b6@redhat.com> (Thomas Huth's
	message of "Fri, 5 Apr 2019 12:57:54 +0200")
Message-ID: <87v9zphux8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 08 Apr 2019 06:29:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/input/pckbd: The i8042 device should
 not be user_creatable
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408062907.Vb2ZYujCW7MoLLMyowbWBQ4rpqBgSAzBX54QGlmun_8@z>

Thomas Huth <thuth@redhat.com> writes:

> On 04/04/2019 18.30, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> On 04/04/2019 15.29, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 4/4/19 12:07 PM, Paolo Bonzini wrote:
>>>>> On 04/04/19 09:14, Thomas Huth wrote:
>>>>>> The i8042 PS/2 controller is part of the chipset on the motherboard.
>>>>>> It is instantiated by the machine init code, and it does not make se=
nse
>>>>>> to allow the user to plug an additional i8042 in any of the free ISA=
 slots.
>>>>>> Thus let's mark the device with user_creatable =3D false.
>>>>>>
>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>> ---
>>>>>>  hw/input/pckbd.c | 2 ++
>>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> user_creatable is not for devices that are not pluggable in real life;
>>>>> it is for devices that crash QEMU (!) or always fail if plugged by th=
e user.
>>>
>>> ... hmm, but presenting devices to the user that are clearly not
>>> intended for direct use is also not very nice, is it?
>>=20
>> Maybe, but hiding them should be separate from marking devices that
>> still defeat device_add.
>>=20
>> In the ideal world, we'd be able to start with an empty board, then
>> build a machine with by wiring together devices.  Say like use
>> device_add to create and plug into parent bus, qom-set link properties
>> to create additional wires.
>
> I agree with you on the vision of creating a machine dynamically - but I
> doubt that we will ever do it with the "high level" -device option or
> device_add HMP/QMP command. You'd likely rather need to introduce a new
> interface / commands for this anyway,

-device is hardly high level.  It's a thin wrapper around
qdev_device_add(), which adds a bit of convenience to the QOM building
blocks.

Machine creation would probably use a configuration file, and work with
the same QOM building blocks.

>                                       which then simply ignore the
> normal user_creatable flag.

Point taken.  However, I'm afraid you've missed my point that hiding
devices from the user should be separate from marking devices that still
defeat device_add.  @user_creatable is about the latter.  Downstreams
sometimes press it into service for the former, which is probably a bad
idea.

The naming of @user_creatable is and has always been political.  Before
it got its current name, it was cannot_instantiate_with_device_add_yet.
This expressed its intent.  I've stopped caring about its name long ago.

If you want to have a flag to hide devices from the user, and you want
to name it user_creatable, go right ahead and rename what's now called
user_creatable to whatever other name you see fit to get it out of the
way.  Just don't press what's now called user_creatable into service for
something else.

>> Plenty of devices fail at the device_add stage, or require additional
>> wiring by code.  These are marked not user_creatable.
>
> Sure, I think we all agree on these kind of devices.
>
> But what about these devices which obviously don't crash QEMU, but are
> completely useless with "-device", since they can not be used in any
> meaningful way? Presenting them to the average user e.g. in the "-device
> help" output is somewhat gruesome, isn't it?

Quoting myself some more: "hiding them should be separate from marking
devices that still defeat device_add."

>>>>> So the question to ask is: would it make sense, and especially work, =
to
>>>>> add an i8042 to machines that do have an ISA bridge (for example the =
Alpha?)
>>=20
>> Scratch the "would it make sense" part, keep the "would it work" part.
>
> I don't see a way how this could really work (in the sense of being
> usable, not in the sense of not crashing QEMU). The device is only
> expected to be there on certain chipssets, the guest does not have a
> possibility to detect this device on systems that do not feature one of
> these chipssets. So you get a device in such a case that simply does
> nothing. How is that useful for you?

Risking to sound like a broken record...  You want to hide certain
devices from the user because they are (in your reasoned opinion) of no
use to the user.  I'm not going to argue about that.  All I want is you
refrain from abusing what is now called @user_creatable for that
purpose.  Telling me that hiding is a good idea won't persuade me this
abuse would be a good idea.

