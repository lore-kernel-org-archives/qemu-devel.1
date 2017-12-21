Received: from eggs.gnu.org ([2001:4830:134:3::10]:36392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eS6CH-0002lR-6z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eS6CD-0007gs-Qb
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:08:01 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:39888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eS6CD-0007gi-LW
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:07:57 -0500
Received: by mail-it0-x242.google.com with SMTP id 68so11973217ite.4
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 11:07:57 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <0e51a7c4-34b1-7b14-c2be-e21e81e6e7fc@redhat.com>
Date: Thu, 21 Dec 2017 14:07:55 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F278FF6-8D20-45FC-88B9-64E6F47A2C98@gmail.com>
References: <0B44C3E6-545D-43B1-B124-97BB9D84BA0C@gmail.com>
	<8bf902fe-1ec9-4845-a072-af2e7da32ed2@redhat.com>
	<29E7CA81-A379-4B37-B174-20EACDEA5E79@gmail.com>
	<0e51a7c4-34b1-7b14-c2be-e21e81e6e7fc@redhat.com>
Subject: Re: [Qemu-devel] About my strnlen patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>


> On Dec 21, 2017, at 1:40 PM, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 12/21/2017 12:36 PM, Programmingkid wrote:
>>> On Dec 21, 2017, at 1:30 PM, Eric Blake <eblake@redhat.com> wrote:
>>>=20
>>> On 12/21/2017 08:31 AM, Programmingkid wrote:
>>>> Now would be a good time to push the strnlen patch.
>>>=20
>>> No links to the patch? Generally, when pinging a patch, it's best to =
reply to the existing thread, or at least provide a URL to the thread, =
where the patch was proposed.
>>>=20
>> Yes here is the patch: https://patchwork.kernel.org/patch/10027375/
>=20
> And that link says it was applied to libfdt on Oct 25.  What still =
needs to happen that caused you to send this ping?

It isn't available in QEMU yet. Without the patch building QEMU on Mac =
OS 10.6 fails.=20

The patch'ed code would be found here: <qemu =
folder>/dtc/libfdt/libfdt_env.h.

I can check on the patch's status by deleting the dtc folder and =
retrieve it again using this command:
$ scripts/git-submodule.sh dtc
