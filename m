Received: from eggs.gnu.org ([2001:4830:134:3::10]:43315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVKQg-0004RS-To
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVKQf-0005Yk-Px
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:23:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVKQf-0005XT-Hd
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:23:57 -0400
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170712150400.GH5237@redhat.com>
	<9d51d348-7ad6-a98d-3f6d-89e8af5e3a16@redhat.com>
	<20170712161254.GJ5237@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <97146c9d-c6c9-161a-f9a0-1a065c183a35@redhat.com>
Date: Wed, 12 Jul 2017 18:23:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170712161254.GJ5237@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12.07.2017 18:12, Daniel P. Berrange wrote:
> On Wed, Jul 12, 2017 at 06:00:46PM +0200, Thomas Huth wrote:
>> On 12.07.2017 17:04, Daniel P. Berrange wrote:
[...]
>>> I think we must document & agree on our support policy for machine
>>> types, before we start marking them as deprecated. eg please consider
>>> the following document before accepting this deprecation patch:
>>>
>>>  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00652.html
>>>
>>> Note in that proposal there, I say we do *not* go through trouble of
>>> explicitly marking machines as deprecated. We just document upfront
>>> the intended lifecycle and then delete them when it is done.
>>>
>>> Just use deprecation warnings for things where there is no predictabl=
e
>>> lifecycle upfront.
>>
>> I'm still not 100% sure whether that auto-deprecation of machine types
>> is such a good idea ... since we might need to maintain machines in
>> downstream a little bit longer than specified there, it might be bette=
r
>> to rather deprecate them manually from time to time.
>=20
> Downstreams usually maintain custom machine types, so fact that the
> upstream machine types get deleted is not a problem in itself. The prob=
lem
> comes if followup internal code removal then prevents downstream from
> creating their custom machine type.

Right, that's what I had in mind.

> I don't think we need tie these
> issues together. We can remove old machine types, without immediately
> removing features that our harm creation of downstream machine types.

I think that won't work. Either the required code gets removed by
accident, or if not, we forget to remove it later, once downstream does
not require it anymore. I think it is better to remove machine types and
the related features code in the upstream code base in one shot. So
manually deprecating machine types and carefully removing them later
sounds like the better approach to me.

> FWIW, I think your proposals have been very useful in general. It has
> been way overdue to have this kind of discussion. I just want us to
> focus on defining a policy, rather than making adhoc decisions each
> time around, as the later is rather unpredictable for users of qemu.

Well, I think your doc updates are also a very good idea, but we could
simply state that we keep the old machine types around for *at least* x
releases or y years. That should give users the same safety as when
we're declaring that old machine types will definitely be removed after
x releases or y years.

 Thomas
