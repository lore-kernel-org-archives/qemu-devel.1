Received: from eggs.gnu.org ([2001:4830:134:3::10]:41010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fT7x5-0001Qn-Bj
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fT7x2-0001YC-IN
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:44:51 -0400
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
	<1528866321-23886-5-git-send-email-thuth@redhat.com>
	<20180613133840.GK24528@stefanha-x1.localdomain>
	<20180613134452.GU19901@redhat.com>
	<b0ebd968-797f-48e0-32c1-869c452feca9@redhat.com>
	<20180613151942.GC19901@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2a2631c6-3af9-237d-6040-ba4d2e42d7ad@redhat.com>
Date: Wed, 13 Jun 2018 17:44:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180613151942.GC19901@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] qemu-options: Do not show
 -enable-kvm and -enable-hax in the docs anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, zhang.zhanghailiang@huawei.com, Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 13.06.2018 17:19, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jun 13, 2018 at 05:11:51PM +0200, Thomas Huth wrote:
>> On 13.06.2018 15:44, Daniel P. Berrang=C3=A9 wrote:
>>> On Wed, Jun 13, 2018 at 02:38:40PM +0100, Stefan Hajnoczi wrote:
>>>> On Wed, Jun 13, 2018 at 07:05:21AM +0200, Thomas Huth wrote:
>>>>> We've got three ways of enabling an accelerator: -machine accel=3Dx=
yz,
>>>>> -accel xyz and -enable-xyz. For new QEMU users, this must be very
>>>>> confusing ("Which one do I have to use? Is there a difference betwe=
en
>>>>> the options?"). While -enable-kvm was useful in the past, there is =
no
>>>>> real good reason for using it anymore today ("-accel kvm" is even l=
ess
>>>>> to type than "-enable-kvm"), so let's decrease the confusing amount=
 of
>>>>> options in our documenation a little bit by removing the -enable-xy=
z
>>>>> here. Note that the option itself is neither removed nor marked as
>>>>> deprecated - since -enable-kvm is likely used in a lot of scripts a=
nd
>>>>> since its code is easy to maintain, we should keep it around to avo=
id
>>>>> to break old setups.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  PS: I guess Paolo won't like this patch ... let's try it anyway ;-=
)
>>>>
>>>> It's widely used and we're removing the documentation for it?!  That=
 is
>>>> likely to cause issues for new users who refer to the man page to
>>>> understand the QEMU command-lines they see online, in scripts, etc.
>>>
>>> Agreed, this is a very bad idea. Any option that is accepted by QEMU,
>>> but not documented is a bug that must be fixed. IOW removing docs
>>> is creating bugs.
>>
>> Not documenting unliked options that are still kept for compatibility
>> was at least a common practice in the past (see -no-kvm for example, o=
r
>> many of those deprecated options like -net channel that have been
>> removed in the past year).
>=20
> If we're planning to deprecate & then delete an option, then I
> don't mind if docs are dropped, but IIUC, in this case we're
> not doing that - the option will essentially exist forever.
>=20
>>> If we want to help users understand why we have -enable-kvm, just
>>> make the docs say that it is syntactic for '-machine accel=3Dkvm'.
>>> Users can decide for themselves whether they want to switch to
>>> the more verbose way or not
>>
>> Uh, well, in this case "-enable-kvm" is already the more verbose way:
>> "-accel kvm" is shorter :-)
>=20
> If I'm a user looking for how to enable KVM, then -enable-kvm is the
> one I'll pick because of the obvious name.

Hmm, maybe we should also add -configure-network-backend,
--configure-character-device-backend and -setup-block-backend as
synonyms for -netdev, -chardev and -blockdev, just because they have a
more obvious name? ;-)

 Thomas
