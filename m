Received: from eggs.gnu.org ([2001:4830:134:3::10]:35027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWKTi-0006Fk-LD
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWKTh-0007sX-PF
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:43:46 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:41900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWKTh-0007sK-LD
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:43:45 -0400
Received: by mail-ot0-x241.google.com with SMTP id d19-v6so7160307oti.8
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 04:43:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_6aJ705HdAD6b4m3fsGBGa6gEQXet5dkgc5aELxeknBw@mail.gmail.com>
References: <20180621145749.191944-1-eblake@redhat.com>
	<CAFEAcA_6aJ705HdAD6b4m3fsGBGa6gEQXet5dkgc5aELxeknBw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 12:43:24 +0100
Message-ID: <CAFEAcA_0xjKVuSrUh5twc07=d-HPVoUc8JH9xunAapWCgpNreQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/9] bitmap export over NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 June 2018 at 10:57, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 21 June 2018 at 15:57, Eric Blake <eblake@redhat.com> wrote:
>> ----------------------------------------------------------------
>> nbd patches for 2018-06-20
>>
>> Add experimental x-nbd-server-add-bitmap to expose a disabled
>> bitmap over NBD, in preparation for a pull model incremental
>> backup scheme. Also fix a corner case protocol issue with
>> NBD_CMD_BLOCK_STATUS, and add new NBD_CMD_CACHE.
>>
>> - Eric Blake: tests: Simplify .gitignore
>> - Eric Blake: nbd/server: Reject 0-length block status request
>> - Vladimir Sementsov-Ogievskiy: 0/6 NBD export bitmaps
>> - Vladimir Sementsov-Ogievskiy: nbd/server: introduce NBD_CMD_CACHE
>>
> Applied, thanks.

...patchew seems to be unhappy, though, eg
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06559.html
has an unrelated patchset failing with:

/tmp/qemu-test/src/nbd/server.c: In function 'nbd_trip':
/tmp/qemu-test/src/nbd/server.c:1980:19: error: 'end' may be used uninitialized
in this function [-Werror=maybe-uninitialized]
     *length = end - offset;
               ~~~~^~~~~~~~
/tmp/qemu-test/src/nbd/server.c:1940:30: note: 'end' was declared here
     uint64_t begin = offset, end;
                              ^~~
cc1: all warnings being treated as errors

thanks
-- PMM
