Received: from eggs.gnu.org ([2001:4830:134:3::10]:41678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqIPP-0002xr-L1
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 07:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqIPN-0000GK-4H
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 07:57:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqIPM-0000GA-VI
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 07:57:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170320180024.23432-1-arvolkov@inbox.ru>
	<87o9wvrmwa.fsf@dusky.pond.sub.org>
	<73e35c44-eda8-318c-77a3-0a7d42704dba@redhat.com>
Date: Tue, 21 Mar 2017 12:56:56 +0100
In-Reply-To: <73e35c44-eda8-318c-77a3-0a7d42704dba@redhat.com> (Paolo
	Bonzini's message of "Tue, 21 Mar 2017 12:22:01 +0100")
Message-ID: <87fui6onav.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hw: dead code removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Anton Volkov <arvolkov@inbox.ru>, borntraeger@de.ibm.com, kraxel@redhat.com, agraf@suse.de, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 21/03/2017 10:37, Markus Armbruster wrote:
>> Four related changes, really:
>> 
>> 1. HDACodecDeviceClass method exit()
>> 2. VirtIOCCWDeviceClass method exit()
>> 3. DeviceClass method exit()
>> 4. SCLPEventClass method exit()
>> 
>> Regarding 3: method exit() needs to go.  Your patch shows there are only
>> a few remaining users.  Please convert them to unrealize().
>
> But that should be a separate patch anyway, so this patch should be good
> as is, shouldn't it?

Separate, yes, but I'd do it first.  Of course that's a matter of taste.
