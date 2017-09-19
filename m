Received: from eggs.gnu.org ([2001:4830:134:3::10]:35635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1duIMl-0000Gn-Cr
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1duIMf-0003yX-Gk
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:15:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27423)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1duIMf-0003wn-8z
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:15:01 -0400
References: <1490347615-19222-1-git-send-email-thuth@redhat.com>
	<f3b0b14e-4ea1-6c4e-f9c6-cb86e78c6104@de.ibm.com>
	<c2195ec9-a3d7-eb14-c204-d5c0e6239811@redhat.com>
	<129fdced-8f83-e408-b37a-26c6ba8bb48f@de.ibm.com>
	<169bbaaf-3212-ce1d-a0db-6edede5b481d@redhat.com>
	<004effcd-142f-d667-3f14-c77c211cd219@de.ibm.com>
	<6f711dfd-84bc-8683-3655-b836bb5d0a51@redhat.com>
	<09c14d39-8867-0a19-aeeb-f8edcd0df66e@redhat.com>
	<3ce8f3c2-1ef5-6e1d-504d-9ca9a68cb818@redhat.com>
	<872bdedf-b0d2-1301-684e-678060ef68a0@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9d6a7693-12b6-b23f-8e52-c808d31ce891@redhat.com>
Date: Tue, 19 Sep 2017 15:14:58 +0200
MIME-Version: 1.0
In-Reply-To: <872bdedf-b0d2-1301-684e-678060ef68a0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x/kvm: Fix problem when running
 with SELinux under z/VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>

>> It's the last remaining alloc hack we have in QEMU :) That's why I am
>> asking the question.
> 
> Hmm, maybe we could remove it for QEMU v3.0 ? ;-)
> 
>  Thomas
> 
> 

Chasing unicorns on rainbows? ;)

-- 

Thanks,

David
