Received: from eggs.gnu.org ([2001:4830:134:3::10]:42421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fT6Vg-0004PT-1C
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fT6Vb-0003Dt-E2
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:12:28 -0400
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
	<1528866321-23886-2-git-send-email-thuth@redhat.com>
	<540abc07-2b96-bf0b-6f5a-2a4efc5184d9@redhat.com>
	<c203ab47-c88b-544d-0233-f7ba48e5e639@redhat.com>
	<dafdc212-9fa1-34c4-d498-23c8a0413e9d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <818e90a5-b61c-cf3d-9910-6cc028e39362@redhat.com>
Date: Wed, 13 Jun 2018 16:12:16 +0200
MIME-Version: 1.0
In-Reply-To: <dafdc212-9fa1-34c4-d498-23c8a0413e9d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] Replace '-machine accel=xyz' with
 '-accel xyz'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, zhang.zhanghailiang@huawei.com

On 13.06.2018 15:54, Paolo Bonzini wrote:
> On 13/06/2018 14:53, Thomas Huth wrote:
>> On 13.06.2018 14:48, Paolo Bonzini wrote:
>>> On 13/06/2018 07:05, Thomas Huth wrote:
>>>> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
>>>> index 8d915c6..4324034 100644
>>>> --- a/tests/vmgenid-test.c
>>>> +++ b/tests/vmgenid-test.c
>>>> @@ -131,7 +131,7 @@ static void read_guid_from_monitor(QemuUUID *guid)
>>>>  static char disk[] = "tests/vmgenid-test-disk-XXXXXX";
>>>>  
>>>>  #define GUID_CMD(guid)                          \
>>>> -    "-machine accel=kvm:tcg "                   \
>>>> +    "-accel kvm:tcg "                           \
>>>>      "-device vmgenid,id=testvgid,guid=%s "      \
>>>
>>> "-accel kvm:tcg" works, but it really shouldn't (and I think we can
>>> change it without a deprecation period).   The right syntax would be
>>> "-accel kvm -accel tcg", so that you can specify options that are valid
>>> only for KVM, or onlty for TCG.
>>
>> I see your point, but this would break these qtests that are trying to
>> override the "-machine accel=qtest" from libqtest.c this way...
> 
> The solution would be to put "-accel kvm -accel tcg" before "-accel qtest".
> 
>> and if
>> any other tool out there in the wild is already depending on this
>> behavior, too, we can not change it so easily anymore.
> 
> I think -accel is new and obscure enough that it's unlikely to be used
> with a colon.  In my opinion, the risk is worth the benefit of finally
> getting a proper interface for accelerators.

I agree with you. Let's try to get this right before it's too late!

 Thomas
