Received: from eggs.gnu.org ([2001:4830:134:3::10]:42589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dUuwG-00077v-Eh
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dUuwA-0001Cg-Kt
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:10:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dUuwA-0001C0-E3
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:10:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D726861D19
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 13:10:44 +0000 (UTC)
Received: from [10.43.2.192] (unknown [10.43.2.192])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DD1A757B1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 13:10:44 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
References: <cover.1496132443.git.mprivozn@redhat.com>
	<d627afbc-5cd8-d831-d089-d1fb30fbfdfd@redhat.com>
Message-ID: <03f93e78-b585-6d01-2c63-5de8dac97abe@redhat.com>
Date: Tue, 11 Jul 2017 15:10:43 +0200
MIME-Version: 1.0
In-Reply-To: <d627afbc-5cd8-d831-d089-d1fb30fbfdfd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix qemu-bridge-helper with SUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 06/22/2017 05:58 PM, Michal Privoznik wrote:
> On 05/30/2017 10:23 AM, Michal Privoznik wrote:
>> For more description see patch 3. Long story short, if the bridge helper runs
>> with SUID, the mechanism we rely on (DAC denying access to ACL files) does not
>> work.
>>
>> Michal Privoznik (3):
>>   qemu-bridge-helper: Reverse return value setting logic
>>   qemu-bridge-helper: Reverse return value setting logic in
>>     parse_acl_file
>>   qemu-bridge-helper: Take ACL file gid into account
>>
>>  qemu-bridge-helper.c | 79 ++++++++++++++++++++++++++++------------------------
>>  1 file changed, 42 insertions(+), 37 deletions(-)
>>
> 
> ping?
> 

ping^2?

Michal
