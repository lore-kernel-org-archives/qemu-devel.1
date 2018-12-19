Received: from eggs.gnu.org ([2001:4830:134:3::10]:46093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZfes-0004sD-CI
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:29:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZfep-00085X-40
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:29:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gZfeo-00084R-Te
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:29:19 -0500
References: <20181211095057.14623-1-fli@suse.com>
	<20181211095057.14623-7-fli@suse.com>
	<87y38tc2fb.fsf@dusky.pond.sub.org>
	<3645fb54-3651-f63b-c416-b22634e1f992@suse.com>
	<87zht1keso.fsf@dusky.pond.sub.org>
	<cc510f12-e94c-bd90-ce01-4ad5d143420f@suse.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9be94c80-623d-c1e7-2524-07b07d05446c@redhat.com>
Date: Wed, 19 Dec 2018 11:29:16 -0600
MIME-Version: 1.0
In-Reply-To: <cc510f12-e94c-bd90-ce01-4ad5d143420f@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v8 6/7] qemu_thread_create:
 propagate the error to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>, Markus Armbruster <armbru@redhat.com>
Cc: David Gibson <dgibson@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 12/19/18 6:14 AM, Fei Li wrote:

>>>>> =C2=A0=C2=A0 28 files changed, 243 insertions(+), 101 deletions(-)

>> I recommend to split this patch.=C2=A0 First part adds the Error ** pa=
rameter
>> to qemu_thread_create(), passing &error_abort everywhere.=C2=A0 No fun=
ctional
>> change.=C2=A0 Subsequent patches then improve on &error_abort.=C2=A0 T=
his way,
>> each improvement patch can be cc'ed to just that part's maintainer(s).
>> Parts you don't want to touch you simply leave at &error_abort.=C2=A0 =
Makes
>> sense?
> Yes, I think this makes sense, much clearer. :) But I am a little=20
> worried about
> whether too many subsequent improvement patches (some of them are quite
> small changes) are acceptable.

A long series of small patches, where each patch is cc'd to an=20
appropriate maintainer, will likely get cumulative reviews faster than a=20
single monolithic patch where no one person is the expert on every line=20
touched.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
