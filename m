Received: from eggs.gnu.org ([2001:4830:134:3::10]:33371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1coz51-0004hS-Q6
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 17:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1coz4x-0007Q7-Rp
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 17:06:35 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1coz4x-0007Q1-MU
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 17:06:31 -0400
Received: by mail-qt0-x243.google.com with SMTP id r5so10987480qtb.2
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 14:06:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <alpine.DEB.2.10.1703161241220.14378@sstabellini-ThinkPad-X260>
	<1489694518-16978-1-git-send-email-sstabellini@kernel.org>
	<1489694518-16978-3-git-send-email-sstabellini@kernel.org>
	<20170317121630.503719ec@bahia.lab.toulouse-stg.fr.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d75727ae-2585-f76c-3d2f-0764b4c6c00c@amsat.org>
Date: Fri, 17 Mar 2017 18:06:26 -0300
MIME-Version: 1.0
In-Reply-To: <20170317121630.503719ec@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/9] 9p: introduce a type for the 9p
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>
Cc: jgross@suse.com, qemu-devel@nongnu.org, Stefano Stabellini <stefano@aporeto.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, anthony.perard@citrix.com, xen-devel@lists.xenproject.org

On 03/17/2017 08:16 AM, Greg Kurz wrote:
> On Thu, 16 Mar 2017 13:01:52 -0700
> Stefano Stabellini <sstabellini@kernel.org> wrote:
>
>> Use the new type in virtio-9p-device.
>>
>> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
>> CC: anthony.perard@citrix.com
>> CC: jgross@suse.com
>> CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> CC: Greg Kurz <groug@kaod.org>
>> ---
>
> Reviewed-by: Greg Kurz <groug@kaod.org>
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>>  hw/9pfs/9p.h               | 6 ++++++
>>  hw/9pfs/virtio-9p-device.c | 6 +-----
>>  2 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
>> index b7e8362..5312d8a 100644
>> --- a/hw/9pfs/9p.h
>> +++ b/hw/9pfs/9p.h
>> @@ -119,6 +119,12 @@ static inline char *rpath(FsContext *ctx, const char *path)
>>  typedef struct V9fsPDU V9fsPDU;
>>  struct V9fsState;
>>
>> +typedef struct {
>> +    uint32_t size_le;
>> +    uint8_t id;
>> +    uint16_t tag_le;
>> +} QEMU_PACKED P9MsgHeader;
>> +
>>  struct V9fsPDU
>>  {
>>      uint32_t size;
>> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
>> index 27a4a32..3782f43 100644
>> --- a/hw/9pfs/virtio-9p-device.c
>> +++ b/hw/9pfs/virtio-9p-device.c
>> @@ -46,11 +46,7 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
>>      VirtQueueElement *elem;
>>
>>      while ((pdu = pdu_alloc(s))) {
>> -        struct {
>> -            uint32_t size_le;
>> -            uint8_t id;
>> -            uint16_t tag_le;
>> -        } QEMU_PACKED out;
>> +        P9MsgHeader out;
>>
>>          elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>>          if (!elem) {
>
