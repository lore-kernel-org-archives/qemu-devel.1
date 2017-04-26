Received: from eggs.gnu.org ([2001:4830:134:3::10]:48038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d3Jwt-0007Py-2K
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d3Jwp-0005Ep-TV
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:13:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40521
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1d3Jwp-0005Eh-OB
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:13:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QA9Jfq033479
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 06:13:23 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a2q25qtp6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 06:13:22 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 26 Apr 2017 06:13:22 -0400
References: <70ef6f1f-27f4-133f-ab33-03a30f19867b@de.ibm.com>
	<20170424105344.GF2362@work-vm>
	<75a4c5ff-385e-31ac-5f86-883b082cd94e@de.ibm.com>
	<20170424143516.GD2075@work-vm>
	<5c0608dd-ba22-dc09-71a1-bb95c977f77d@de.ibm.com>
	<20170424191202.GQ2362@work-vm>
	<097a5085-1128-cf2d-abc4-54660a608f36@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 26 Apr 2017 12:13:17 +0200
MIME-Version: 1.0
In-Reply-To: <097a5085-1128-cf2d-abc4-54660a608f36@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <81fb2c37-fe68-732e-85a5-a6f797e6ec2d@de.ibm.com>
Subject: Re: [Qemu-devel] postcopy migration hangs while loading virtio state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 04/26/2017 11:59 AM, Christian Borntraeger wrote:

> source:
> 28863@1493200554.418978:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419047:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419056:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419064:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419071:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419077:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419083:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419088:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419094:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419100:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419106:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419112:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419117:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419123:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419130:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419138:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419145:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419151:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419156:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419163:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419169:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419174:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419179:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419184:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419189:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419208:qemu_savevm_send_postcopy_ram_discard s390.ram: 9d
> 28863@1493200554.818195:migrate_handle_rp_req_pages in s390.ram at 3c6b000 len 1000
> 28863@1493200554.818208:ram_save_queue_pages s390.ram: start: 3c6b000 len: 1000
> 28863@1493200554.818469:get_queued_page_not_dirty s390.ram/3c6b000 ram_addr=3c6b000 (sent=0)
> 
> I also get 
> ram_save_page: s390.ram:3c6b000

looks like this one happens before the discards.
