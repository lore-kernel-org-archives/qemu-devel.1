Received: from eggs.gnu.org ([2001:4830:134:3::10]:42014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dpDcI-0004x2-3g
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dpDc8-00068x-P6
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:10:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dpDc8-000680-FG
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:10:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85D90Z2096666
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 09:09:59 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2csv9nh15s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 09:09:58 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 5 Sep 2017 14:09:55 +0100
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-18-david@redhat.com>
	<f162eece-8dd0-a8e9-f339-356465ab6587@de.ibm.com>
	<cdc6b4d0-117a-be80-cd3e-d2a4592f061d@redhat.com>
	<41bbb466-4b9d-1c7e-f622-38a867b1db65@de.ibm.com>
	<20170905145417.05fa0fae.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 5 Sep 2017 15:09:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170905145417.05fa0fae.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <fc130b3f-1526-18fa-a9d9-52658ebf23c0@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 17/19] s390x: CPU hot unplug via
 device_del cannot work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>



On 09/05/2017 02:54 PM, Cornelia Huck wrote:
[...]
> Having the cpu in the unconfigured state as a requirement also makes
> this less likely to break for older OSs, I guess.
> 
>> Right now SCLP_CMDW_(DE)CONFIGURE_CPU seems to be unimplemented in
>> QEMU.
> 
> Sounds like something we'd like to have in the future?
> 
> (Btw, what does cpuplugd trigger? Offline/online or
> deconfigure/configure?)

offline/online via sigp stop/start. When we hotplug we already
provide the new cpu in the configured state (like z/VM).
