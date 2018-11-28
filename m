Received: from eggs.gnu.org ([2001:4830:134:3::10]:33156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS3Yg-00049w-HT
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS3Yd-0000Uu-MJ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:23:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64473)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gS3Yd-0000Rg-EE
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:23:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F6FE30832C1
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 17:23:26 +0000 (UTC)
References: <20181128153526.10948-1-berrange@redhat.com>
	<31667b3c-0071-e2b3-63d1-2fdc0c96c98f@redhat.com>
	<20181128172001.GV24355@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f027ff7a-de22-ba85-5737-68599cddadce@redhat.com>
Date: Wed, 28 Nov 2018 11:23:25 -0600
MIME-Version: 1.0
In-Reply-To: <20181128172001.GV24355@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Document how to test the site
 with jekyll locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 11/28/18 11:20 AM, Daniel P. Berrang=C3=A9 wrote:
>>> +Note the 'vendor/' path has been explicitly excluded from the web co=
ntent
>>> +in _config.yml, so don't try to use a different path within the git
>>> +checkout.
>>> +
>>> +
>>> +To test the site launch jeykll
>>> +
>>> +  # bundle exec jekyll serve
>>
>> $ bundle exec jekyll serve
>> Configuration file: /home/eblake/qemu-web/_config.yml
>> Configuration file: /home/eblake/qemu-web/_config.yml
>>              Source: /home/eblake/qemu-web
>>         Destination: /home/eblake/qemu-web/_site
>>   Incremental build: disabled. Enable with --incremental
>>        Generating...
>>               ERROR: YOUR SITE COULD NOT BE BUILT:
>>                      ------------------------------------
>>                      Invalid date '<%=3D Time.now.strftime('%Y-%m-%d %=
H:%M:%S
>> %z') %>': Document 'vendor/ruby/2.5.0/gems/jekyll-3.3.0/lib/site_templ=
ate/_posts/0000-00-00-welcome-to-jekyll.markdown.erb'
>> does not have a valid date in the YAML front matter.
>>
>> Did I do things right?
>=20
> Yes, but this error is what the addition in _config.yml.....

Ah, my fault for not actually applying the patch before trying the=20
commands.  With the patched _config.yml,...

>=20
>>> diff --git a/_config.yml b/_config.yml
>>> index 0a0201c..576b0a5 100644
>>> --- a/_config.yml
>>> +++ b/_config.yml
>>> @@ -37,3 +37,5 @@ gems:
>>>    exclude:
>>>      - Gemfile
>>>      - Gemfile.lock
>>> +  - vendor/
>>> +  - README
>=20
> ...here is supposed to fix, so I'm puzzelled why you'd still get that
> error message

...I have a live local server.

Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
