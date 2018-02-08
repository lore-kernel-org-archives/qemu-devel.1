Received: from eggs.gnu.org ([2001:4830:134:3::10]:44949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejnj5-0002RD-86
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejnj0-0001gb-8M
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:03:03 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:40238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejnj0-0001fu-1w
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:02:58 -0500
Received: by mail-wm0-f48.google.com with SMTP id v123so10537872wmd.5
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 07:02:57 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-13-rkagan@virtuozzo.com>
	<ac191902-8f59-8064-f5cf-39bf79f4d035@redhat.com>
	<20180207191126.GD18247@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d28f2507-afe4-dc9a-ac65-11a017734084@redhat.com>
Date: Thu, 8 Feb 2018 16:02:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180207191126.GD18247@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 12/34] hyperv: add synic event flag
 signaling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 07/02/2018 20:11, Roman Kagan wrote:
>>> +/*
>>> + * Set given event flag for a given sint on a given vcpu, and signal the sint.
>>> + */
>>> +int hyperv_set_evt_flag(HvSintRoute *sint_route, unsigned evtno)
>> Any reason (e.g. something from the spec) not to spell "event" and
>> "eventno" in full?
> None beyond me being on the "shortest-comprehensible-name" camp :)
> 
> I thought "evt" was unambiguously parsed as "event", and "msg" as
> "message".  Isn't it?

Yes, it's understandable, however my guess would have been that "msg" is
way more common than "evt".  grep seems to agree

  $ git grep '\Bmessage\|message\B' | wc -l
  451
  $ git grep '\Bmsg\|msg\B' | wc -l
  2504

  $ git grep '\Bevent\|event\B' | wc -l
  4998
  $ git grep '\Bevt\|evt\B' | wc -l
  483

where quite a few "evt" instances are matching "devtree" or "devtype".

("\Bfoo|foo\B" avoids the cases where "foo" is an entire word, which
would probably favor "message" and "event" when they appear as English
text).

Paolo
