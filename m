Received: from eggs.gnu.org ([2001:4830:134:3::10]:60404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqHrf-0003Lo-ER
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 07:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqHrc-0001vX-Rw
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 07:22:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cqHrc-0001v1-Lr
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 07:22:08 -0400
References: <20170320180024.23432-1-arvolkov@inbox.ru>
	<87o9wvrmwa.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <73e35c44-eda8-318c-77a3-0a7d42704dba@redhat.com>
Date: Tue, 21 Mar 2017 12:22:01 +0100
MIME-Version: 1.0
In-Reply-To: <87o9wvrmwa.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw: dead code removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Anton Volkov <arvolkov@inbox.ru>
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, kraxel@redhat.com



On 21/03/2017 10:37, Markus Armbruster wrote:
> Four related changes, really:
> 
> 1. HDACodecDeviceClass method exit()
> 2. VirtIOCCWDeviceClass method exit()
> 3. DeviceClass method exit()
> 4. SCLPEventClass method exit()
> 
> Regarding 3: method exit() needs to go.  Your patch shows there are only
> a few remaining users.  Please convert them to unrealize().

But that should be a separate patch anyway, so this patch should be good
as is, shouldn't it?

Paolo
