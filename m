Received: from eggs.gnu.org ([2001:4830:134:3::10]:39629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1eqfVx-0005kS-1z
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1eqfVt-00018d-W0
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:41:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1eqfVt-00018A-NR
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:41:49 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RDdE2p083743
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:41:48 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gd5t4qcw1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:41:47 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 13:41:45 -0000
References: <1518797321-28356-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518797321-28356-5-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180219155728.00d0075e.cohuck@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 14:41:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180219155728.00d0075e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <1fba4dff-e252-93af-da3b-ce81f6edf55b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCHv5 4/5] qemu-doc: deprecate query-cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com

On 19.02.2018 15:57, Cornelia Huck wrote:
> On Fri, 16 Feb 2018 17:08:40 +0100
> Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
> 
>> Start the deprecation period for QAPI query-cpus (replaced by
>> query-cpus-fast) beginning with 2.12.0.
>>
>> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>  qapi-schema.json | 4 ++++
>>  qemu-doc.texi    | 4 ++++
>>  2 files changed, 8 insertions(+)
> 
> We need to remember updating the deprecation notes in the wiki as well.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
Let me know whether you plan on doing that or I should take a crack at it.

-- 
Regards,
 Viktor Mihajlovski
