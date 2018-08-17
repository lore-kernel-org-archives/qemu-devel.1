Received: from eggs.gnu.org ([2001:4830:134:3::10]:44116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fqcMW-0007Vb-4A
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fqcMS-0003dA-6h
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:52:12 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fqcMR-0003ce-QX
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:52:08 -0400
Received: by mail-wr1-x443.google.com with SMTP id e7-v6so6704936wrs.9
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 03:52:07 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1534491213-24748-1-git-send-email-thuth@redhat.com>
	<20180817094819.GE11124@redhat.com>
	<adc83475-3772-ca87-8498-3b5df1ddf046@redhat.com>
	<20180817095944.GF11124@redhat.com> <20180817100424.GA21930@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea45aa5b-85ac-72ce-2914-bcf405630d94@redhat.com>
Date: Fri, 17 Aug 2018 12:52:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180817100424.GA21930@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] qom: Rename object_new_with_props to
 object_new_child
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Gerd Hoffmann <kraxel@redhat.com>

On 17/08/2018 12:04, Daniel P. Berrangé wrote:
> On Fri, Aug 17, 2018 at 10:59:44AM +0100, Daniel P. Berrangé wrote:
>> On Fri, Aug 17, 2018 at 11:58:07AM +0200, Thomas Huth wrote:
>>> On 08/17/2018 11:48 AM, Daniel P. Berrangé wrote:
>>>> On Fri, Aug 17, 2018 at 09:33:33AM +0200, Thomas Huth wrote:
>>>>> While adding the object_initialize_child() function, Paolo suggested
>>>>> to rename the similar object_new_with_props() function accordingly:
>>>>>
>>>>> http://marc.info/?i=e034610d-9a1d-a8a5-ee92-b2e3f0ba2891@redhat.com
>>>>>
>>>>> This way it is more obvious that this function creates a new object
>>>>> as a child of another object.
>>>>
>>>> I'd expect 'object_new_with_child' to be the same as 'object_new',
>>>> but with only 'parent' & 'id' args added, which isn't the case here.
>>>>
>>>> If we want the full & consistent design then we should have
>>>>
>>>>   object_new(typename)
>>>>   object_new_with_child(typename, parent, id)
>>>>   object_new_props(typename, ...)
>>>>   object_new_propv(typename, va_arg props)
>>>>   object_new_with_child_props(typename, parent, id, ...)
>>>>   object_new_with_child_propv(typename, parent, id, va_arg props)
>>>
>>> "new_with_child" sounds wrong, too, since the parent is not created
>>> here, but the child. Anyway, I guess the naming of these functions is
>>> too much subject to bikeshedding, so never mind, let's keep it as it
>>> currently is.
>>
>> True, 'new_with_parent' is a better choice in retrospect :-)
> 
> Or indeed 'object_new_child' and 'object_new_child_prop{s,v}' approx as
> you had suggested

That would work for me too.  Really anything works as long as the
initialize and new names are consistent.

In practice object_new_child would be unused, hence the shortcut of
adding the props argument directly to object_new_child{,v}.

Thanks,

Paolo
