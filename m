Received: from eggs.gnu.org ([2001:4830:134:3::10]:54042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g8XQd-000320-O3
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g8XQ6-0000CB-2j
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:14:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g8XQ5-0000B8-Pt
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:13:57 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A4D230014BD
	for <qemu-devel@nongnu.org>; Fri,  5 Oct 2018 21:13:57 +0000 (UTC)
References: <1538748792-19444-1-git-send-email-thuth@redhat.com>
	<20181005163012.01bb7e73.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e06fb68b-da6b-3b2a-0c4c-3be13886fa9f@redhat.com>
Date: Fri, 5 Oct 2018 23:13:53 +0200
MIME-Version: 1.0
In-Reply-To: <20181005163012.01bb7e73.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] accel: Improve selection of the default
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On 05/10/2018 16:30, Cornelia Huck wrote:
>> +        }
>>      }
>>  
>>      accel_list = g_strsplit(accel, ":", 0);
> ISTR that we had a suggestion last time that we should provide
> qemu-kvm, qemu-tcg, etc. binaries...

Not qemu-tcg, as that would be qemu-system-*, but yes that was my
suggestion.  Compared to it, Thomas's patch provides almost the same
benefit and has the big advantage of existing.

Paolo
