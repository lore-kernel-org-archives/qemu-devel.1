Received: from eggs.gnu.org ([209.51.188.92]:35605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfvn-0007AR-GN
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfvl-0002VW-GC
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:04:19 -0400
References: <20190404091725.20595-1-dgilbert@redhat.com>
	<20190404091957.GL10471@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <87f831be-0707-2820-8378-e0cf617fa3c7@vivier.eu>
Date: Thu, 11 Apr 2019 22:03:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190404091957.GL10471@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] configure: fix pam test
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 04/04/2019 11:19, Daniel P. Berrangé wrote:
> CC trivial
> 
> On Thu, Apr 04, 2019 at 10:17:25AM +0100, Dr. David Alan Gilbert (git) wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> The pam test generates a warning on Fedora 29 with -O3 compilation
>> because the headers declare that the pam_conversation pointer to
>> pam_start must be non-NULL.  Change it to use the same 0 initialised
>> structure as we actually use in qauthz.
>>
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>  configure | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Acked-by: Daniel P. Berrangé <berrange@redhat.com>
> 
>>
>> diff --git a/configure b/configure
>> index 1c563a7027..73f7ad2be0 100755
>> --- a/configure
>> +++ b/configure
>> @@ -2946,9 +2946,9 @@ if test "$auth_pam" != "no"; then
>>  int main(void) {
>>     const char *service_name = "qemu";
>>     const char *user = "frank";
>> -   const struct pam_conv *pam_conv = NULL;
>> +   const struct pam_conv pam_conv = { 0 };
>>     pam_handle_t *pamh = NULL;
>> -   pam_start(service_name, user, pam_conv, &pamh);
>> +   pam_start(service_name, user, &pam_conv, &pamh);
>>     return 0;
>>  }
>>  EOF
> 
> Regards,
> Daniel
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
