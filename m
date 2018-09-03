Received: from eggs.gnu.org ([2001:4830:134:3::10]:47211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fwn81-0003Bi-5w
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fwn7w-0000CC-DE
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:34:44 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:36064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fwn7w-0000Bx-5y
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:34:40 -0400
Received: by mail-ed1-x544.google.com with SMTP id f4-v6so547586edq.3
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 04:34:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <009b673f-7872-af95-77a7-2bc7de4658e6@redhat.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-3-sameeh@daynix.com>
	<009b673f-7872-af95-77a7-2bc7de4658e6@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 3 Sep 2018 14:34:38 +0300
Message-ID: <CAKPgXcGv=hj-x1LHOBxpMwYP2UQvoV5n0H_hZUx8=sGL+TApiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 2/6] tap: Add support for bpf ioctls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>

On Thu, Aug 30, 2018 at 6:21 PM, Eric Blake <eblake@redhat.com> wrote:
> On 08/30/2018 09:27 AM, Sameeh Jubran wrote:
>>
>> From: Sameeh Jubran <sjubran@redhat.com>
>>
>> Starting from kernel v4.16 tun device supports TUNSETSTEERINGEBPF and
>> TUNSETFILTEREBPF.
>>
>> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>> ---
>
>
>> +++ b/qapi/net.json
>> @@ -692,3 +692,14 @@
>>   ##
>>   { 'event': 'NIC_RX_FILTER_CHANGED',
>>     'data': { '*name': 'str', 'path': 'str' } }
>> +
>> +##
>> +# @BPFType:
>> +#
>> +# BPF programs types provided as an argument for tap bpf ioctls
>> +#
>> +# Since: 2.12
>
>
> You missed 2.12 by a long shot; this should be 3.1.
Yup, but it seems like I'm dropping this from QAPI,
Thanks
>
>> +#
>> +##
>> +{ 'enum': 'BPFType',
>> +  'data': [ 'filter', 'steering' ] }
>
>
> It might also be wise to document these two values in addition to the
> documentation of the enum as a whole.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org



-- 
Respectfully,
Sameeh Jubran
Linkedin
Software Engineer @ Daynix.
