Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2975C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EAE622B3F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fhvW6Bcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAE622B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1YjB-00078k-UR
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Yhv-00065m-Vh
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:20:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Yhr-0006m5-GJ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:20:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VHHFXT006670;
 Fri, 31 Jul 2020 17:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fd0BwTLAoJkG0uu9o/4Kim6z1xuG8/N0Dq+xB593BoY=;
 b=fhvW6Bcq1DJX0YYynH1i+42R/tOWagecDQGbAawRUtZ9Oov6P3DTmE0uamN14qcw55nr
 j0c+DG4iQ1ooIBi0clV6F6wefmxbmDl8DM15je1TAt65YHGdo4lYLg0plNRxzYTdoomI
 rKvvDy02F7xzxtGjkm29yBoT0UDm7f4t5gdswDHA7+bWrRjrCTcl2y5VvJGtvvN9TUzU
 EOZnR2nff7nnp0/fbhXPQTuDT2wZ0bo0Zlqfn+XA6vL2/KBytXuYK9dWT1rxEBgOwCJ0
 gUlX/8QWdTi5BPs8oHGttf1AT2nObPS+RieOx/C00hZmeRllvUD0AptPYiYtXyU5UT4C GA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 32hu1jt77c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 17:20:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VHIc1S113376;
 Fri, 31 Jul 2020 17:20:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 32hu64kuv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 17:20:27 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VHKQhA015962;
 Fri, 31 Jul 2020 17:20:26 GMT
Received: from [10.39.235.87] (/10.39.235.87)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 10:20:26 -0700
Subject: Re: [PATCH V1 00/32] Live Update
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <20200730165249.GR3477223@redhat.com>
 <aa6940d9-7c2a-bdc2-edaf-ea4fea56e61f@oracle.com>
 <20200731085349.GB3518939@redhat.com>
 <dcb66c6b-cb2a-1848-d83b-2dc27be400f3@oracle.com>
 <20200731155252.GE3660103@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <e715f264-ca75-eb55-84e3-ab75587e66c1@oracle.com>
Date: Fri, 31 Jul 2020 13:20:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200731155252.GE3660103@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310130
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=steven.sistare@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:51:59
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/2020 11:52 AM, Daniel P. Berrangé wrote:
> On Fri, Jul 31, 2020 at 11:27:45AM -0400, Steven Sistare wrote:
>> On 7/31/2020 4:53 AM, Daniel P. Berrangé wrote:
>>> On Thu, Jul 30, 2020 at 02:48:44PM -0400, Steven Sistare wrote:
>>>> On 7/30/2020 12:52 PM, Daniel P. Berrangé wrote:
>>>>> On Thu, Jul 30, 2020 at 08:14:04AM -0700, Steve Sistare wrote:
>>>>>> Improve and extend the qemu functions that save and restore VM state so a
>>>>>> guest may be suspended and resumed with minimal pause time.  qemu may be
>>>>>> updated to a new version in between.
>>>>>>
>>>>>> The first set of patches adds the cprsave and cprload commands to save and
>>>>>> restore VM state, and allow the host kernel to be updated and rebooted in
>>>>>> between.  The VM must create guest RAM in a persistent shared memory file,
>>>>>> such as /dev/dax0.0 or persistant /dev/shm PKRAM as proposed in 
>>>>>> https://lore.kernel.org/lkml/1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com/
>>>>>>
>>>>>> cprsave stops the VCPUs and saves VM device state in a simple file, and
>>>>>> thus supports any type of guest image and block device.  The caller must
>>>>>> not modify the VM's block devices between cprsave and cprload.
>>>>>>
>>>>>> cprsave and cprload support guests with vfio devices if the caller first
>>>>>> suspends the guest by issuing guest-suspend-ram to the qemu guest agent.
>>>>>> The guest drivers suspend methods flush outstanding requests and re-
>>>>>> initialize the devices, and thus there is no device state to save and
>>>>>> restore.
>>>>>>
>>>>>>    1 savevm: add vmstate handler iterators
>>>>>>    2 savevm: VM handlers mode mask
>>>>>>    3 savevm: QMP command for cprsave
>>>>>>    4 savevm: HMP Command for cprsave
>>>>>>    5 savevm: QMP command for cprload
>>>>>>    6 savevm: HMP Command for cprload
>>>>>>    7 savevm: QMP command for cprinfo
>>>>>>    8 savevm: HMP command for cprinfo
>>>>>>    9 savevm: prevent cprsave if memory is volatile
>>>>>>   10 kvmclock: restore paused KVM clock
>>>>>>   11 cpu: disable ticks when suspended
>>>>>>   12 vl: pause option
>>>>>>   13 gdbstub: gdb support for suspended state
>>>>>>
>>>>>> The next patches add a restart method that eliminates the persistent memory
>>>>>> constraint, and allows qemu to be updated across the restart, but does not
>>>>>> allow host reboot.  Anonymous memory segments used by the guest are
>>>>>> preserved across a re-exec of qemu, mapped at the same VA, via a proposed
>>>>>> madvise(MADV_DOEXEC) option in the Linux kernel.  See
>>>>>> https://lore.kernel.org/lkml/1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com/
>>>>>>
>>>>>>   14 savevm: VMS_RESTART and cprsave restart
>>>>>>   15 vl: QEMU_START_FREEZE env var
>>>>>>   16 oslib: add qemu_clr_cloexec
>>>>>>   17 util: env var helpers
>>>>>>   18 osdep: import MADV_DOEXEC
>>>>>>   19 memory: ram_block_add cosmetic changes
>>>>>>   20 vl: add helper to request re-exec
>>>>>>   21 exec, memory: exec(3) to restart
>>>>>>   22 char: qio_channel_socket_accept reuse fd
>>>>>>   23 char: save/restore chardev socket fds
>>>>>>   24 ui: save/restore vnc socket fds
>>>>>>   25 char: save/restore chardev pty fds
>>>>>
>>>>> Keeping FDs open across re-exec is a nice trick, but how are you dealing
>>>>> with the state associated with them, most especially the TLS encryption
>>>>> state ? AFAIK, there's no way to serialize/deserialize the TLS state that
>>>>> GNUTLS maintains, and the patches don't show any sign of dealing with
>>>>> this. IOW it looks like while the FD will be preserved, any TLS session
>>>>> running on it will fail.
>>>>
>>>> I had not considered TLS.  If a non-qemu library maintains connection state, then
>>>> we won't be able to support it for live update until the library provides interfaces
>>>> to serialize the state.
>>>>
>>>> For qemu objects, so far vmstate has been adequate to represent the devices with
>>>> descriptors that we preserve.
>>>
>>> My main concern about this series is that there is an implicit assumption
>>> that QEMU is *not* configured with certain features that are not handled
>>> If QEMU is using one of the unsupported features, I don't see anything in
>>> the series which attempts to prevent the actions.
>>>
>>> IOW, users can have an arbitrary QEMU config, attempt to use these new features,
>>> the commands may well succeed, but the user is silently left with a broken QEMU.
>>> Such silent failure modes are really undesirable as they'll lead to a never
>>> ending stream of hard to diagnose bug reports for QEMU maintainers.
>>>
>>> TLS is one example of this, the live upgrade  will "succeed", but the TLS
>>> connections will be totally non-functional.
>>
>> I agree with all your points and would like to do better in this area.  Other than hunting for 
>> every use of a descriptor and either supporting it or blocking cpr, do you have any suggestions?
>> Thinking out loud, maybe we can gather all the fds that we support, then look for all fds in the
>> process, and block the cpr if we find an unrecognized fd.
> 
> There's no magic easy answer to this problem. Conceptually it is similar to
> the problem of reliably migrating guest device state, but in this case we're
> primarily concerned about the backends instead.
> 
> For migration we've got standardized interfaces that devices must implement
> in order to correctly support migration serialization. There is also support
> for devices to register migration "blockers" which prevent any use of the
> migration feature when the device is present.
> 
> We lack this kind of concept for the backend, and that's what I think needs
> to be tackled in a more thorough way.  There are quite alot of backends,
> but they're grouped into a reasonable small number of sets (UIs, chardevs,
> blockdevs, net devs, etc). We need some standard interface that we can
> plumb into all the backends, along with providing backends the ability to
> block the re-exec. If we plumb the generic infrastructure into each of the
> different types of backend, and make the default behaviour be to reject
> the re-exec. Then we need to carefull consider specific  backend impls
> and allow the re-exec only in the very precise cases we can demonstrate
> to be safe.
> 
> IOW, have a presumption that re-exec will *not* be permitted. Over time
> we can make it work for an ever expanding set of use cases. 

Actually, we could use the vmstate mode_mask field added in patch 2, and only allow the restart
mode for vmstate objects that have been vetted.  Currently an uninitialized mask (value 0)
enables the object for all modes, but we could change that.

- Steve

