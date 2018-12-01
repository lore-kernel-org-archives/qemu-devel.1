Received: from eggs.gnu.org ([2001:4830:134:3::10]:45640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gT3s4-0007D4-6O
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 06:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gT3s1-0006uE-0M
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 06:55:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gT3s0-0006tp-Qn
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 06:55:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so1416826wmh.1
	for <qemu-devel@nongnu.org>; Sat, 01 Dec 2018 03:55:36 -0800 (PST)
References: <20181130111222.25386-1-kraxel@redhat.com>
	<20181130111222.25386-3-kraxel@redhat.com>
	<75c973a5-f571-e69e-e2fd-72d3b3b118b2@redhat.com>
	<bfce1b7d-6b41-0296-605e-e63ed359d249@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c0da7ecd-4929-e64c-347d-a80b5368a47d@redhat.com>
Date: Sat, 1 Dec 2018 12:55:33 +0100
MIME-Version: 1.0
In-Reply-To: <bfce1b7d-6b41-0296-605e-e63ed359d249@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/2] usb-mtp: outlaw slashes in
 filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Michael Hanselmann <hansmi@vshn.ch>, Michael Hanselmann <public@hansmi.ch>

On 30/11/18 20:58, Eric Blake wrote:
> On 11/30/18 1:08 PM, Philippe Mathieu-Daudé wrote:
>> On 30/11/18 12:12, Gerd Hoffmann wrote:
>>> Slash is unix directory separator, so they are not allowed in filenames.
>>> Note this also stops the classic escape via "../".
>>>
>>> Fixes: CVE-2018-16867
>>> Reported-by: Michael Hanselmann (hansmi.ch)
>>
>> It's common for scripts to match '<email>', can you write this one as
>> Michael Hanselmann <hansmi.ch>?
> 
> That's not an email address, though. Do we have an email for Michael, or
> just a username?
> 

I did not notice hehe :)

Per the gpg key: Michael Hanselmann <public@hansmi.ch>
Per git commits: Michael Hanselmann <hansmi@vshn.ch>

Cc'ed him so he can decide/confirm.
