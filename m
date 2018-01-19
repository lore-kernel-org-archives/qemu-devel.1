Received: from eggs.gnu.org ([2001:4830:134:3::10]:40870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecRJD-0005nL-5A
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 02:41:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecRJ9-0005Ei-21
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 02:41:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecRJ8-0005DJ-Rw
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 02:41:50 -0500
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
	<ecc919de-5193-a83c-0e29-4b8d9bc8d7d7@redhat.com>
	<e0cbd675-7872-05c3-8c3e-214ef93e4552@redhat.com>
	<002201d38b9d$f0a248d0$d1e6da70$@ru>
	<357a23a7-2cac-a14d-f4b9-7f883b101ea7@redhat.com>
	<001e01d390ef$ba73c890$2f5b59b0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50884d44-a368-6434-03d5-9aba86b2dcba@redhat.com>
Date: Fri, 19 Jan 2018 08:41:39 +0100
MIME-Version: 1.0
In-Reply-To: <001e01d390ef$ba73c890$2f5b59b0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 00/30] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org

On 19/01/2018 07:35, Pavel Dovgalyuk wrote:
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> On 12/01/2018 13:07, Pavel Dovgalyuk wrote:
>>>
>>> I can't build current version of qemu on Windows.
>>> For the first time this happened when capstone was included into the build.
>>
>> I've fixed it now.  
> 
> Is upstream version ok?
> I still cannot build it on Windows.

I only fixed the mutex tracing patches.  It builds for me with mingw.

Paolo
