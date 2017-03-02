Received: from eggs.gnu.org ([2001:4830:134:3::10]:43635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjNSC-0007br-SS
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjNSB-0003NU-V6
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:55:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjNSB-0003MO-Ow
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:55:19 -0500
References: <1488272804-27144-1-git-send-email-kraxel@redhat.com>
	<CAJSP0QVhb6FPh9HaC--7vqRgetuBQNvYt9BxeCp9KaNOTfLe8g@mail.gmail.com>
	<CAFEAcA-QvbAUs5bS6w8_BBFS7-2msfxPeDGE8HVS3z5LKMQKPw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5db40f1e-0fc0-f66b-ba9e-6919a6108cc6@redhat.com>
Date: Thu, 2 Mar 2017 10:55:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-QvbAUs5bS6w8_BBFS7-2msfxPeDGE8HVS3z5LKMQKPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/1] seabios: update to 1.10.2 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>



On 01/03/2017 18:40, Peter Maydell wrote:
> On 1 March 2017 at 13:27, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Tue, Feb 28, 2017 at 9:06 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>> Our seabios.git mirror @ qemu.org seems to not sync properly.  The
>>> commit isn't there even though it was pushed a few days ago already
>>> (only the tag was pushed today).  John, can you have a look please?
>>> master branch, *-stable branches and all tags should be mirrored.
>>
>> Hi Gerd,
>> It looks like the git mirrors weren't updating.  I kicked it and the
>> necessary commit is now in the QEMU seabios.git mirror repo.
>>
>> It should be safe to merge this pull request now.
> 
> $ git submodule update
> fatal: reference is not a tree: 5f4c7b13cdf9c450eb55645f4362ea58fa61b79b
> Unable to checkout '5f4c7b13cdf9c450eb55645f4362ea58fa61b79b' in
> submodule path 'roms/seabios'
> 
> Maybe this will update overnight?

The commit was there, but HEAD was not being updated.  Fixed now.

Paolo
