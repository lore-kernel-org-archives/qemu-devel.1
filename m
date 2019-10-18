Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F091CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A9021D80
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A9021D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLMSx-0003X0-VW
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iLMSE-00038C-SW
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iLMSC-0003nB-36
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:13:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iLMSB-0003mn-Q8
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:13:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62099C069B4B;
 Fri, 18 Oct 2019 07:13:38 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCFBD19C77;
 Fri, 18 Oct 2019 07:13:24 +0000 (UTC)
Subject: Re: Python 2 and test/vm/netbsd
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20191016030021.GD4084@habkost.net>
 <a83d518a-6e39-0017-203d-2ee3d61935ca@redhat.com>
 <20191016224124.GF4084@habkost.net> <20191017220541.GJ4084@habkost.net>
 <20191017225548.GL4084@habkost.net>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <e911f108-3351-20c1-0430-e773868d1e9b@redhat.com>
Date: Fri, 18 Oct 2019 09:13:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017225548.GL4084@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 18 Oct 2019 07:13:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/10/2019 00.55, Eduardo Habkost wrote:
> On Thu, Oct 17, 2019 at 07:05:41PM -0300, Eduardo Habkost wrote:
>> On Wed, Oct 16, 2019 at 07:41:24PM -0300, Eduardo Habkost wrote:
>>> On Wed, Oct 16, 2019 at 08:11:57AM +0200, Thomas Huth wrote:
>>>> On 16/10/2019 05.00, Eduardo Habkost wrote:
>>>>> On Tue, Sep 17, 2019 at 08:31:40PM -0300, Eduardo Habkost wrote:
>>>>>> On Mon, Jul 01, 2019 at 07:25:27PM -0300, Eduardo Habkost wrote:
>>>>>>> On Mon, Jun 10, 2019 at 01:58:50PM +0100, Peter Maydell wrote:
>>>>> [...]
>>>>>>>> The configure check also spits out deprecation warnings for
>>>>>>>> the NetBSD/FreeBSD/OpenBSD tests/vm configurations. It would be nice
>>>>>>>> to get those updated.
>>>>>>>
>>>>>>> CCing the test/vm maintainers.
>>>>>>>
>>>>>>> Fam, Alex, are you able to fix this and create new BSD VM images
>>>>>>> with Python 3 available?  I thought the VM image configurations
>>>>>>> were stored in the source tree, but they are downloaded from
>>>>>>> download.patchew.org.
>>>>>>
>>>>>> Fam, Alex, can you help us on this?  Python 2 won't be supported
>>>>>> anymore, so we need the VM images to be updated.
>>>>>
>>>>> Anyone?
>>>>>
>>>>> I'm about to submit patches to remove Python 2 support, and this
>>>>> will break tests/vm/netbsd.
>>>>>
>>>>> I'm powerless to fix this issue, because the netbsd image is
>>>>> hosted at download.patchew.org.
>>>>
>>>> Gerd had a patch to convert the netbsd VM script to ad hoc image
>>>> creation, too:
>>>>
>>>> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04459.html
>>>>
>>>> But there was a regression with the serial port between QEMU v3.0 and
>>>> v4.x, so it was not included:
>>>>
>>>> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06784.html
>>>
>>> The URL above has this error:
>>>
>>>   con recv:  x: Exitqqqqqqqqqqqqqqqqqqqqqqqqqj
>>>   con recv: To be able to use the network, we need answers to the
>>>   following:Network media type
>>>   con send: <enter>
>>>   con recv: : qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk Perform autoconfiguration?
>>>      >a: Yes b: Noqqqqqqqqqqqqqqqqq
>>>   console: *** read timeout ***
>>>   console: waiting for: 'a: Yes'
>>>   console: line buffer:
>>>   
>>>   con recv: qqqqqqqqqqqqqqj
>>>
>>> I believe that problem was solved in v4, because v4 was reading
>>> the serial output 1 byte at a time.
>>>
>>> The issue that caused the netbsd patch to be dropped was:
>>> https://lore.kernel.org/qemu-devel/CAFEAcA8k9QJA9iE-kwiaPhr0fY_2zG7JRX5uV4AaSSjXCSs4+A@mail.gmail.com/
>>>
>>> Possibly this is the same issue we saw at:
>>> https://lore.kernel.org/qemu-devel/20190607034214.GB22416@habkost.net/
>>>
>>> The test script must either close the console socket, or keep
>>> reading from it.  Otherwise, the QEMU VCPU threads might get
>>> stuck waiting for the chardev to be writeable.
>>
>> It doesn't seem to be the same issue.  Even if the console socket is closed,
>> I'm seeing results similar to the ones reported by Peter (the "pkgin -y
>> install" step is unreasonably slow).
>>
>> Running with V=1, I see packages being downloaded at reasonable speeds, but
>> there's a huge interval (of various minutes) between each package download.
> 
> I've found the cause for the slowness I'm seeing: for each file
> being downloaded, the guest spents at least 75 seconds trying to
> connect to the IPv6 address of ftp.NetBSD.org, before trying
> IPv4.  I don't know if this is a NetBSD bug, or a slirp bug.

Does it work better if you turn IPv6 off? E.g.:

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -81,7 +81,7 @@ class BaseVM(object):
         self._args = [ \
             "-nodefaults", "-m", "4G",
             "-cpu", "max",
-            "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
+            "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22,ipv6=off",
             "-device", "virtio-net-pci,netdev=vnet",
             "-vnc", "127.0.0.1:0,to=20"]
         if vcpus and vcpus > 1:

 Thomas


> Output of `strace -e trace=network` below:
> 
> 1571352260.348566 recvfrom(30, "~[\201\200\0\1\0\1\0\0\0\0\3ftp\6NetBSD\3org\0\0\1\0\1"..., 1500, 0, {sa_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("10.5.30.160")}, [128->16]) = 48 <0.000016>
> 1571352260.349030 socket(AF_INET6, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 31 <0.000041>
> 1571352260.349142 setsockopt(31, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0 <0.000009>
> 1571352260.349179 setsockopt(31, SOL_SOCKET, SO_OOBINLINE, [1], 4) = 0 <0.000007>
> 1571352260.349207 setsockopt(31, SOL_TCP, TCP_NODELAY, [1], 4) = 0 <0.000008>
> 1571352260.349239 connect(31, {sa_family=AF_INET6, sin6_port=htons(80), sin6_flowinfo=htonl(67108864), inet_pton(AF_INET6, "2001:470:a085:999::21", &sin6_addr), sin6_scope_id=377348480}, 28) = -1 ENETUNREACH (Network is unreachable) <0.000
> 021>
> 1571352266.350112 socket(AF_INET6, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 31 <0.000131>
> 1571352266.350603 setsockopt(31, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0 <0.000183>
> 1571352266.350946 setsockopt(31, SOL_SOCKET, SO_OOBINLINE, [1], 4) = 0 <0.000047>
> 1571352266.351109 setsockopt(31, SOL_TCP, TCP_NODELAY, [1], 4) = 0 <0.000043>
> 1571352266.351260 connect(31, {sa_family=AF_INET6, sin6_port=htons(80), sin6_flowinfo=htonl(67108864), inet_pton(AF_INET6, "2001:470:a085:999::21", &sin6_addr), sin6_scope_id=377348480}, 28) = -1 ENETUNREACH (Network is unreachable) <0.000070>
> 1571352278.357962 socket(AF_INET6, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 29 <0.000166>
> 1571352278.358524 setsockopt(29, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0 <0.000046>
> 1571352278.358757 setsockopt(29, SOL_SOCKET, SO_OOBINLINE, [1], 4) = 0 <0.000046>
> 1571352278.358950 setsockopt(29, SOL_TCP, TCP_NODELAY, [1], 4) = 0 <0.000039>
> 1571352278.359103 connect(29, {sa_family=AF_INET6, sin6_port=htons(80), sin6_flowinfo=htonl(67108864), inet_pton(AF_INET6, "2001:470:a085:999::21", &sin6_addr), sin6_scope_id=377348480}, 28) = -1 ENETUNREACH (Network is unreachable) <0.000065>
> 1571352302.373056 socket(AF_INET6, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 29 <0.000323>
> 1571352302.373909 setsockopt(29, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0 <0.000162>
> 1571352302.374331 setsockopt(29, SOL_SOCKET, SO_OOBINLINE, [1], 4) = 0 <0.000159>
> 1571352302.374626 setsockopt(29, SOL_TCP, TCP_NODELAY, [1], 4) = 0 <0.000050>
> 1571352302.374857 connect(29, {sa_family=AF_INET6, sin6_port=htons(80), sin6_flowinfo=htonl(67108864), inet_pton(AF_INET6, "2001:470:a085:999::21", &sin6_addr), sin6_scope_id=377348480}, 28) = -1 ENETUNREACH (Network is unreachable) <0.000070>
> 1571352335.394568 socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 29 <0.000091>
> 1571352335.394796 setsockopt(29, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0 <0.000011>
> 1571352335.394848 setsockopt(29, SOL_SOCKET, SO_OOBINLINE, [1], 4) = 0 <0.000009>
> 1571352335.394883 setsockopt(29, SOL_TCP, TCP_NODELAY, [1], 4) = 0 <0.000008>
> 1571352335.394913 connect(29, {sa_family=AF_INET, sin_port=htons(80), sin_addr=inet_addr("199.233.217.201")}, 16) = -1 EINPROGRESS (Operation now in progress) <0.000055>
> 1571352335.587395 sendto(29, "", 0, 0, NULL, 0) = 0 <0.000220>
> 1571352335.589650 sendto(29, "GET /pub/pkgsrc/packages/NetBSD/"..., 81, 0, NULL, 0) = 81 <0.000088>
> 


