Received: from eggs.gnu.org ([2001:4830:134:3::10]:48195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d8oSv-0002Mf-Pa
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d8oSv-0008VC-4U
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:49:13 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170510143205.32013-1-pbonzini@redhat.com>
	<20170510143205.32013-5-pbonzini@redhat.com>
	<17fd54d8-fba0-b44e-91ea-18e4e18e9f16@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c9f98146-b265-9f51-6e7c-01087dc84670@redhat.com>
Date: Thu, 11 May 2017 15:49:02 +0200
MIME-Version: 1.0
In-Reply-To: <17fd54d8-fba0-b44e-91ea-18e4e18e9f16@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] curl: split
 curl_find_state/curl_init_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com



On 10/05/2017 19:26, Max Reitz wrote:
>> +    if (curl_init_state(s, state) < 0) {
>> +        curl_clean_state(state);
>
> We could also initialize state to NULL and call curl_clean_state() under
> out: if state != NULL. Then again, it would only save us two
> curl_clean_state() instances...
> 
> So I'll leave it to you and unconditionally give a
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Makes sense, but OTOH you could also move locking to curl_co_preadv and
get rid of "out" altogether.  So for now I left curl_clean_state here.

Paolo
