Received: from eggs.gnu.org ([2001:4830:134:3::10]:56894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZj5I-00076V-0k
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZj5F-0007Uv-KM
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:59:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cZj5F-0007Uk-F9
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:59:45 -0500
References: <1483601042-6435-1-git-send-email-jitendra.kolhe@hpe.com>
	<20170127132650.GA31231@redhat.com>
	<67bd733e-5974-327b-25f4-c83b8e379313@hpe.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <13f0f2e5-7c1d-b050-e3d6-0b504a803ae4@redhat.com>
Date: Fri, 3 Feb 2017 10:59:37 -0800
MIME-Version: 1.0
In-Reply-To: <67bd733e-5974-327b-25f4-c83b8e379313@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] mem-prealloc: Reduce large guest
 start-up and migration time.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jitendra Kolhe <jitendra.kolhe@hpe.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "armbru@redhat.com" <armbru@redhat.com>, "MeenakshiSundaram, Renganathan" <renganathan.meenakshisundaram@hpe.com>, "Parthasarathy, Mohan (HPE Servers)" <mohan_parthasarathy@hpe.com>



On 02/02/2017 01:35, Jitendra Kolhe wrote:
>> Of course you'd still need the memset() trick if qemu was given
>> non-hugepages in combination with --mem-prealloc, as you don't
>> want to lock normal pages into ram permanently.
>>
> given above numbers, I think we can stick to memset() implementation for
> both hugepage and non-hugepage cases?

Yes, of course!

Paolo
