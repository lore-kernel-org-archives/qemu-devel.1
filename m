Received: from eggs.gnu.org ([2001:4830:134:3::10]:40294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8iBm-0008MX-KG
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8iBi-0006w0-KR
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:07:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8iBi-0006ua-Dz
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:07:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1494398933-8366-1-git-send-email-thuth@redhat.com>
	<20170510090841.GF31558@redhat.com>
	<e8f7410f-98d9-2e0e-b75d-0ff38fd81b35@redhat.com>
	<20170510103153.GI31558@redhat.com>
	<ccb8fecd-e918-1cc0-28ef-af9865540fbc@redhat.com>
	<157a6609-d75a-5d40-e5b9-c70802e40950@redhat.com>
Date: Thu, 11 May 2017 09:06:54 +0200
In-Reply-To: <157a6609-d75a-5d40-e5b9-c70802e40950@redhat.com> (Paolo
	Bonzini's message of "Wed, 10 May 2017 18:15:39 +0200")
Message-ID: <87pofflvn5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Deprecate the machines pc-0.10 to
 pc-0.15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/05/2017 16:47, Thomas Huth wrote:
>>> So while we can delete pc-0.12, we can't delete associated features needed
>>> by pc-0.12, without complicating RHEL's ability to create its back-compat
>>> machine types. Downstream would have to un-delete the features.
>>
>> So I guess this is why Paolo said that pc-0.12 is still in "use" ... I
>> think removing pc-0.12, but not removing rombar=0 will cause confusion
>> in the upstream code base sooner or later,
>
> I agree.
>
>> so I guess we should rather
>> keep the pc-0.12 machine until we can get rid of it together with the
>> rombar code. We should still mark it as deprecated, of course.
>>
>>> I think tieing removal to major versions is a mistake, unless we're
>>> going to set a fixed timeframe for delivery of major versions. ie if
>>> we gaurantee that we'll ship a new major version every 18 months, that
>>> gives people a predictable lifetime.  If we carry on inventing reasons
>>> for major versions at arbitrary points in time, it makes it difficult
>>> to have any reasonable forward planning.  It is more users friendly if
>>> we can set a clear fixed timeframe for machine type lifecycle / eol
>>
>> IMHO we should have a new major release after we've reached a .9 minor
>> release, but so far it seems like I'm the only one with that wish...
>
> I actually like that, but then you've pretty much guaranteed that you
> _cannot_ remove anything deprecated until 4.0.  You and Daniel aren't
> disagreeing as heavily as it seems, I think.

Even better: drop the '.', and stop worrying about having to wait for
some arbitrary number to come up before you're allowed to do something
;)
