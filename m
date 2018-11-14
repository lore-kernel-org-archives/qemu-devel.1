Received: from eggs.gnu.org ([2001:4830:134:3::10]:53026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMx3X-0003UU-QF
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMx3V-0006F2-6j
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:26:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMx3V-0006Br-1T
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:26:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id k15-v6so17701399wre.12
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 07:26:12 -0800 (PST)
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114142642.GA3103@stefanha-x1.localdomain>
	<20181114143038.GL19298@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a7147dd9-db2b-894a-30dc-09a0fda06e6d@redhat.com>
Date: Wed, 14 Nov 2018 16:26:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181114143038.GL19298@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 00/41] RFC: slirp: make it again a
 standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, rjones@redhat.com, renzo@cs.unibo.it, qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org

On 14/11/18 15:30, Daniel P. Berrangé wrote:
> On Wed, Nov 14, 2018 at 02:26:42PM +0000, Stefan Hajnoczi wrote:
>> On Wed, Nov 14, 2018 at 04:36:02PM +0400, Marc-André Lureau wrote:
[...]
>>
>> Maybe in the future there will be a tests too.  Right now my impression
>> is that slirp isn't hardened and suitable for production use cases (i.e.
>> security).  But with some love (and testing!) I think that could change.
> 
> With Marc-André's desire to move it to a separate process, it is the
> kind of thing where seccomp could actually do a fairly good job as it
> would be a narrow enough piece of functionality that you can put some
> meaningful constraints around it.

It will also become easier to fuzz.
