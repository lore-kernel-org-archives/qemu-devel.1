Received: from eggs.gnu.org ([2001:4830:134:3::10]:59443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eo9Ab-0001JZ-0P
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eo9AW-0006Mf-OZ
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:45:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eo9AW-0006MB-Im
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:45:20 -0500
References: <CAG9FBFpFBrUrG0bRwjAo6xHYG4rnc0BT_ufLSa-HsO2WWgvKJw@mail.gmail.com>
	<3de4128f-7749-fc52-d5ec-5744b4e74301@redhat.com>
	<20180220083857.5l33rci3iz35uaze@sirius.home.kraxel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <869bcfe6-8199-d7fa-7193-4bb17f6d6ca7@redhat.com>
Date: Tue, 20 Feb 2018 08:45:00 -0600
MIME-Version: 1.0
In-Reply-To: <20180220083857.5l33rci3iz35uaze@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu warnings and errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, James Barrett <xucaen@gmail.com>

On 02/20/2018 02:38 AM, Gerd Hoffmann wrote:
>    Hi,
> 
>> What version of QEMU?
>>
>>> unknown keycodes `(unnamed)', please report to qemu-devel@nongnu.org
>>
>> This part is the only part that urges you to report the error, but I
>> don't know much about what's going on here.
>>
>> Maybe Gerd knows?
> 
> We had lots of keymap/keycode changes recently, most likely this will be
> fixed in 2.12, maybe it already is in 2.11.  So, when using something
> older, try upgrading first (or just ignore it in case it happes to be a
> key you don't need).

The error message doesn't mention a numeric code or other way to figure 
out which key is problematic.  While this particular message may 
disappear when you upgrade, it would also be worth investigating if this 
message can give more details to figure out which keycode is problematic 
in case of future mismatches, other than just "unnamed".

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
