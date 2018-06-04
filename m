Received: from eggs.gnu.org ([2001:4830:134:3::10]:48059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fPrlN-0002eT-Tl
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fPrlK-0005FU-6Z
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:51:17 -0400
References: <20180417153945.20737-1-pbonzini@redhat.com>
	<20180417153945.20737-7-pbonzini@redhat.com>
	<c07b6574-b20b-28db-157d-15d882cd072c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <369237e8-a956-9e17-6f95-ff0e059f2591@redhat.com>
Date: Mon, 4 Jun 2018 17:51:03 +0200
MIME-Version: 1.0
In-Reply-To: <c07b6574-b20b-28db-157d-15d882cd072c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] ide: introduce
 ide_transfer_start_norecurse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

On 02/06/2018 03:17, John Snow wrote:
> 
> 
> On 04/17/2018 11:39 AM, Paolo Bonzini wrote:
>> For the case where the end_transfer_func is also the caller of
>> ide_transfer_start, the mutual recursion can lead to unlimited
>> stack usage.  Introduce a new version that can be used to change
>> tail recursion into a loop, and use it in trace_ide_atapi_cmd_reply_end.
> 
> probably you mean ide_atapi_cmd_reply_end

Yeah.  Cut-and-paste...

Paolo

>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
