Received: from eggs.gnu.org ([2001:4830:134:3::10]:37055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cmIGf-00072Q-Cy
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cmIGc-0003di-C7
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:59:29 -0500
References: <20170309115830.3860-1-pbonzini@redhat.com>
	<a74b9e2a-dd72-8179-c2e2-c215093e8fef@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5295b123-f4ce-fb95-1469-221be84bbf8e@redhat.com>
Date: Fri, 10 Mar 2017 18:59:18 +0800
MIME-Version: 1.0
In-Reply-To: <a74b9e2a-dd72-8179-c2e2-c215093e8fef@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] e1000e: correctly tear down MSI-X memory
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, qemu-stable@nongnu.org



On 2017=E5=B9=B403=E6=9C=8809=E6=97=A5 20:05, Laurent Vivier wrote:
> On 09/03/2017 12:58, Paolo Bonzini wrote:
>> MSI-X has been disabled by the time the e1000e device is unrealized, h=
ence
>> msix_uninit is never called.  This causes the object to be leaked, whi=
ch
>> shows up as a RAMBlock with empty name when attempting migration.
>>
>> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   hw/net/e1000e.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
>> index b0f429b..6e23493 100644
>> --- a/hw/net/e1000e.c
>> +++ b/hw/net/e1000e.c
>> @@ -306,7 +306,7 @@ e1000e_init_msix(E1000EState *s)
>>   static void
>>   e1000e_cleanup_msix(E1000EState *s)
>>   {
>> -    if (msix_enabled(PCI_DEVICE(s))) {
>> +    if (msix_present(PCI_DEVICE(s))) {
>>           e1000e_unuse_msix_vectors(s, E1000E_MSIX_VEC_NUM);
>>           msix_uninit(PCI_DEVICE(s), &s->msix, &s->msix);
>>       }
>>
> Tested-by: Laurent Vivier <lvivier@redhat.com>
>

Applied, thanks.
