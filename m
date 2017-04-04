Received: from eggs.gnu.org ([2001:4830:134:3::10]:37336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvMCA-0007c0-Fs
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvMC7-00070S-AO
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:00:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvMC7-00070D-5Q
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:00:15 -0400
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
	<4d684062-be31-153e-3f94-b1193440c8e3@redhat.com>
	<e2fb3ffd-006c-5908-9201-d3182edc4c04@enea.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <778c2cbf-536e-8349-dbd4-23cf30ac4e43@redhat.com>
Date: Tue, 4 Apr 2017 13:00:08 +0200
MIME-Version: 1.0
In-Reply-To: <e2fb3ffd-006c-5908-9201-d3182edc4c04@enea.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "ciprian.barbu" <ciprian.barbu@enea.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, svc-armband <armband@enea.com>, Jeff Cody <jcody@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>



On 04/04/2017 10:17, ciprian.barbu wrote:
>>
>> but we do NOT make any guarantees of supporting
>>
>> new qemu, old libvirt
> 
> Sounds reasonable enough, I guess we didn't look at it this way.

Yes, but usually it's "new qemu, very old libvirt", like several years
old.  I think this should be treated as a regression.

Between this issue and the problem with snapshots, it seems to me that
the op blockers was really, really premature.

Paolo
