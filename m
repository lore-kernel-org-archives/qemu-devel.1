Received: from eggs.gnu.org ([2001:4830:134:3::10]:37033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e44Mc-00042k-N1
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e44MZ-0003G2-DU
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:19:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e44MZ-0003Ek-4q
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:19:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A7AEC04AC5F
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 12:19:18 +0000 (UTC)
References: <20171016091802.11532-1-david@redhat.com>
	<ccae3743-2b8e-bca5-a124-10242f477836@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <994593b1-1115-46d2-e721-e436a6659cf8@redhat.com>
Date: Mon, 16 Oct 2017 14:19:13 +0200
MIME-Version: 1.0
In-Reply-To: <ccae3743-2b8e-bca5-a124-10242f477836@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] memory: call log_start after region_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

On 16/10/2017 11:36, David Hildenbrand wrote:
>> -        if (fr->dirty_log_mask && listener->log_start) {
>> -            listener->log_start(listener, &section, 0, fr->dirty_log_mask);
>> -        }
>>          if (listener->region_add) {
>>              listener->region_add(listener, &section);
>>          }
>> +        if (fr->dirty_log_mask && listener->log_start) {
>> +            listener->log_start(listener, &section, 0, fr->dirty_log_mask);
>> +        }
>>      }
>>      if (listener->commit) {
>>          listener->commit(listener);
>>
> ... deciding to tolerate it in KVM instead (just as it used to be), so
> please ignore this patch.

Why?  It makes no sense to start logging on a non-existent region, and
this behavior is unique to listener_add_address_space.

Paolo
